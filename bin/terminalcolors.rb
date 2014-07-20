#!/usr/bin/env ruby

# http://stackoverflow.com/questions/1403353/256-color-terminal-library-for-ruby

def ansi_color(red, green, blue)
  16 + (red * 36) + (green * 6) + blue
end

def twenty_four_bit_to_eight_bit_rbg(v)
  red   = (v & 0xff0000) >> 16
  green = (v & 0x00ff00) >>  8
  blue  = (v & 0x0000ff)
  [red, green, blue]
end

def eight_bit_to_scale_of_six(byte)
  (byte * (6.0 / 256.0)).to_i
end

def eight_bit_rgb_to_scale_of_six(rgb)
  rgb.map { |n| eight_bit_to_scale_of_six(n) }
end

def scale_of_six_rgb(v)
  *rgb = twenty_four_bit_to_eight_bit_rbg(v)
  eight_bit_rgb_to_scale_of_six(rgb)
end


solarized = [
  [:base03      , 0x002b36],
  [:base02      , 0x073642],
  [:base01      , 0x586e75],
  [:base00      , 0x657b83],
  [:base0       , 0x839496],
  [:base1       , 0x93a1a1],
  [:base2       , 0xeee8d5],
  [:base3       , 0xfdf6e3],
  [:yellow      , 0xb58900],
  [:orange      , 0xcb4b16],
  [:red         , 0xdc322f],
  [:magenta     , 0xd33682],
  [:violet      , 0x6c71c4],
  [:blue        , 0x268bd2],
  [:cyan        , 0x2aa198],
  [:green       , 0x719e07],
]

#foo = [
#  [:bg, 0x002b36],
#]

solarized.each do |name, v|
  puts "%s: %s" % [name, ansi_color(*scale_of_six_rgb(v))]
end
