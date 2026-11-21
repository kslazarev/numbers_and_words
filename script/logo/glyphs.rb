# frozen_string_literal: true

require_relative 'binary'

module Logo
  # Reads TrueType glyph outlines as contours of [x, y, on_curve] points in font units.
  class Glyphs
    include Binary

    def initialize(data, glyf:, loca:, long_offsets:)
      @data = data
      @glyf = glyf
      @loca = loca
      @long_offsets = long_offsets
    end

    def contours(id)
      offset = offset(id)
      return [] if offset == offset(id + 1)

      start = @glyf + offset
      s16(start).negative? ? compound(start + 10) : simple(start)
    end

    private

    def offset(id)
      @long_offsets ? u32(@loca + (4 * id)) : 2 * u16(@loca + (2 * id))
    end

    def simple(start)
      ends = (0...s16(start)).map { |i| u16(start + 10 + (2 * i)) }
      split(read_points(start + 10 + (2 * ends.size), ends.last + 1), ends)
    end

    # Splits points into contours at each contour's last point index.
    def split(points, ends)
      [-1, *ends].each_cons(2).map { |from, to| points.slice(from + 1, to - from) }
    end

    def read_points(instructions, count)
      flags, at = read_flags(instructions + 2 + u16(instructions), count)
      xs, at = read_coordinates(flags, at, 0x02, 0x10)
      ys, = read_coordinates(flags, at, 0x04, 0x20)
      flags.each_with_index.map { |flag, i| [xs[i], ys[i], flag.allbits?(0x01)] }
    end

    def read_flags(at, count)
      flags = []
      while flags.size < count
        flag = u8(at)
        repeat = flag.allbits?(0x08)
        flags.concat([flag] * (repeat ? u8(at + 1) + 1 : 1))
        at += repeat ? 2 : 1
      end
      [flags, at]
    end

    # Decodes delta-encoded coordinates: a one-byte delta whose sign is in same_or_positive, or a two-byte
    # delta unless same_or_positive marks the coordinate as unchanged.
    def read_coordinates(flags, at, short, same_or_positive)
      value = 0
      coordinates = flags.map do |flag|
        delta, size = coordinate_delta(flag, at, short, same_or_positive)
        at += size
        value += delta
      end
      [coordinates, at]
    end

    def coordinate_delta(flag, at, short, same_or_positive)
      return [flag.allbits?(same_or_positive) ? u8(at) : -u8(at), 1] if flag.allbits?(short)
      return [0, 0] if flag.allbits?(same_or_positive)

      [s16(at), 2]
    end

    def compound(at)
      result = []
      loop do
        flags = u16(at)
        glyph = u16(at + 2)
        matrix, at = read_component(flags, at + 4)
        result.concat(contours(glyph).map { |points| transform(points, matrix) })
        return result unless flags.allbits?(0x20)
      end
    end

    # Reads a compound glyph component's offset and scale; only offsets given as x and y values are supported.
    def read_component(flags, at)
      raise ArgumentError, 'compound glyphs anchored by points are not supported' unless flags.allbits?(0x02)

      words = flags.allbits?(0x01)
      offset = words ? [s16(at), s16(at + 2)] : [s8(at), s8(at + 1)]
      scale, at = read_scale(flags, at + (words ? 4 : 2))
      [scale + offset, at]
    end

    def read_scale(flags, at)
      return [[f2dot14(at), 0, 0, f2dot14(at)], at + 2] if flags.allbits?(0x08)
      return [[f2dot14(at), 0, 0, f2dot14(at + 2)], at + 4] if flags.allbits?(0x40)
      return [(0..3).map { |i| f2dot14(at + (2 * i)) }, at + 8] if flags.allbits?(0x80)

      [[1, 0, 0, 1], at]
    end

    def transform(points, matrix)
      xx, xy, yx, yy, dx, dy = matrix
      points.map { |x, y, on| [(xx * x) + (yx * y) + dx, (xy * x) + (yy * y) + dy, on] }
    end
  end
end
