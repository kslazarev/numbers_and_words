# frozen_string_literal: true

require_relative 'binary'

module Logo
  # Maps characters to glyphs with a font's Windows Unicode BMP (format 4) character map.
  class CharacterMap
    include Binary

    def initialize(data, cmap)
      @data = data
      @map = find_subtable(cmap)
      @segments = u16(@map + 6)
      @ends = @map + 14
      @starts = @ends + @segments + 2
      @deltas = @starts + @segments
      @ranges = @deltas + @segments
    end

    def glyph_id(char)
      code = char.ord
      segment = (0...(@segments / 2)).find { |i| u16(@ends + (2 * i)) >= code }
      id = segment && code >= u16(@starts + (2 * segment)) ? glyph_in_segment(code, 2 * segment) : 0
      raise ArgumentError, "#{char.inspect} is not in the font" if id.zero?

      id
    end

    private

    def find_subtable(cmap)
      (0...u16(cmap + 2)).each do |i|
        record = cmap + 4 + (8 * i)
        subtable = cmap + u32(record + 4)
        return subtable if u16(record) == 3 && u16(record + 2) == 1 && u16(subtable) == 4
      end
      raise ArgumentError, 'the font has no Unicode BMP character map'
    end

    def glyph_in_segment(code, index)
      range = @ranges + index
      id = u16(range).zero? ? code : u16(range + u16(range) + (2 * (code - u16(@starts + index))))
      return 0 if id.zero?

      (id + u16(@deltas + index)) & 0xFFFF
    end
  end
end
