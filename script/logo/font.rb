# frozen_string_literal: true

require_relative 'binary'
require_relative 'character_map'
require_relative 'glyphs'

module Logo
  # A TrueType font's advance widths and glyph outlines, read with the Ruby standard library only.
  class Font
    include Binary

    attr_reader :units_per_em

    def initialize(path)
      @data = File.binread(path)
      @tables = read_tables
      head = table('head')
      @units_per_em = u16(head + 18)
      @metrics_count = u16(table('hhea') + 34)
      @characters = CharacterMap.new(@data, table('cmap'))
      @glyphs = Glyphs.new(@data, glyf: table('glyf'), loca: table('loca'), long_offsets: s16(head + 50) == 1)
    end

    def glyph_id(char)
      @characters.glyph_id(char)
    end

    def advance(id)
      u16(table('hmtx') + (4 * [id, @metrics_count - 1].min))
    end

    def contours(id)
      @glyphs.contours(id)
    end

    private

    def read_tables
      (0...u16(4)).to_h do |i|
        record = 12 + (16 * i)
        [@data[record, 4].strip, u32(record + 8)]
      end
    end

    def table(tag)
      @tables.fetch(tag)
    end
  end
end
