#!/usr/bin/env ruby
# frozen_string_literal: true

# Generates assets/logo.svg, the numbers_and_words logo, with its lettering converted to outlines.
#
# Usage: ruby script/logo.rb FONTS_DIR [OUTPUT]
#
# FONTS_DIR must contain IBMPlexMono-Medium.ttf and SpaceGrotesk-Bold.ttf; see CONTRIBUTING.md.

require_relative 'logo/font'
require_relative 'logo/layout'

abort 'Usage: ruby script/logo.rb FONTS_DIR [OUTPUT]' unless ARGV[0]

fonts = ARGV[0]
layout = Logo::Layout.new(
  mono: Logo::Font.new(File.join(fonts, 'IBMPlexMono-Medium.ttf')),
  grotesk: Logo::Font.new(File.join(fonts, 'SpaceGrotesk-Bold.ttf'))
)
File.write(ARGV[1] || 'assets/logo.svg', layout.to_svg)
