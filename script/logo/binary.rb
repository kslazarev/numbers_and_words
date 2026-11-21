# frozen_string_literal: true

module Logo
  # Big-endian reads from font data held in @data.
  module Binary
    private

    def u8(at) = @data.getbyte(at)
    def s8(at) = @data[at].unpack1('c')
    def u16(at) = @data[at, 2].unpack1('n')
    def s16(at) = @data[at, 2].unpack1('s>')
    def u32(at) = @data[at, 4].unpack1('N')
    def f2dot14(at) = s16(at) / 16_384.0
  end
end
