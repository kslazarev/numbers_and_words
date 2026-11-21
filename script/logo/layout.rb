# frozen_string_literal: true

require_relative 'outline'

module Logo
  # Lays out the logo: a red 42 tile says "forty-two" through a speech bubble drawn in front of it, followed
  # by ".to_words". The lettering is converted to outlines so the SVG renders the same everywhere.
  class Layout
    INK = '#1c2430'
    RED = '#c2453c'
    GREY = '#8a94a6'
    WHITE = '#ffffff'

    # The bubble is right-aligned in the frame; its narrow tail points down-left and overlaps the tile.
    SCALE = 5 / 6r
    RIGHT = 158
    BOTTOM = 72
    WIDTH = 143 * SCALE
    HEIGHT = 56 * SCALE
    LEFT = RIGHT - WIDTH
    TOP = BOTTOM - HEIGHT
    RADIUS = 8 * SCALE

    Style = Struct.new(:font, :points, :fill)

    def initialize(mono:, grotesk:)
      @mono = mono
      @grotesk = grotesk
    end

    def to_svg
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" width="160" height="160" role="img">' \
        "<title>numbers_and_words</title>#{tile}#{bubble}#{said}#{call}</svg>\n"
    end

    private

    def tile
      number = Style.new(@grotesk, 40, WHITE)
      %(<rect x="10" y="82" width="70" height="70" rx="12" fill="#{RED}"/>) +
        text(number, '42', 45 - (width(number, '42') / 2), 132)
    end

    def bubble
      %(<path d="#{bubble_path}" fill="#{WHITE}" stroke="#{INK}" stroke-width="3" stroke-linejoin="round"/>)
    end

    # A rounded rectangle traced clockwise, with the tail on its bottom edge.
    def bubble_path
      "M#{f(LEFT + RADIUS)} #{f(TOP)}H#{f(RIGHT - RADIUS)}#{corner(' ', ' ')}V#{f(BOTTOM - RADIUS)}" \
        "#{corner('-', ' ')}H#{f(LEFT + 36)}l-16 16 2-16H#{f(LEFT + RADIUS)}#{corner('-', '-')}" \
        "V#{f(TOP + RADIUS)}#{corner(' ', '-')}z"
    end

    def corner(x_sign, y_sign)
      r = format('%.4f', RADIUS)
      "a#{r} #{r} 0 0 1#{x_sign}#{r} #{y_sign}#{r}".squeeze(' ')
    end

    # "forty-two" centered in the bubble, with red quotes.
    def said
      quote = Style.new(@mono, 19 * SCALE, RED)
      runs = [[quote, '"'], [Style.new(@mono, quote.points, INK), 'forty-two'], [quote, '"']]
      left = ((LEFT + RIGHT) / 2) - (width(quote, '"forty-two"') / 2)
      line(runs, left, TOP + (HEIGHT / 2) + (quote.points * 0.36))
    end

    # Styled runs of text set one after another on a baseline.
    def line(runs, left, baseline)
      runs.sum('') do |style, string|
        text(style, string, left, baseline).tap { left += width(style, string) }
      end
    end

    def call
      text(Style.new(@mono, 13, GREY), '.to_words', 86, 124)
    end

    def width(style, string)
      string.each_char.sum { |char| style.font.advance(style.font.glyph_id(char)) } * scale(style)
    end

    def scale(style)
      style.points / style.font.units_per_em.to_f
    end

    # The string as one outlined path per glyph, starting at left with its baseline at baseline.
    def text(style, string, left, baseline)
      paths = string.each_char.filter_map do |char|
        id = style.font.glyph_id(char)
        glyph = glyph(style, id, left, baseline)
        left += style.font.advance(id) * scale(style)
        glyph
      end
      %(<g fill="#{style.fill}">#{paths.join}</g>)
    end

    def glyph(style, id, left, baseline)
      d = Outline.path(style.font.contours(id))
      return if d.empty?

      s = format('%.5f', scale(style))
      %(<path transform="translate(#{f(left)} #{f(baseline)}) scale(#{s} -#{s})" d="#{d}"/>)
    end

    def f(value)
      format('%.2f', value)
    end
  end
end
