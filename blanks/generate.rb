# Generate SVG for a Eurorack blank panel

# Numbers taken from https://doepfer.de/a100_man/a100m_e.htm

# Dimensions in mm
HP = 5.08
width_in_hp = ARGV[0].to_f
width = (width_in_hp * HP) - 0.34
hole_spacing = (((width - 7.5) / HP).floor - 1) * HP # -1 to make sure we're more than 1HP from the edge

circles = [
  [7.5, 3.0], # Left upper
  [7.5, 125.0], # Left lower
]

if hole_spacing > HP
  circles << [7.5 + hole_spacing, 3.0] # Right upper
  circles << [7.5 + hole_spacing, 125.0] # Right lower
end

circles_svg = circles
  .map { |x, y| %Q(<circle fill="none" stroke="red" r="1.6mm" cx="#{x}mm" cy="#{y}mm" />) }
  .join("\n")

puts <<EOSVG
<?xml version="1.0" encoding="UTF-8" standalone="no"?>

<svg width="#{width}mm" height="128.5mm" xmlns="http://www.w3.org/2000/svg">
  <g id="cut">
    <rect fill="none" stroke="red" width="#{width}mm" height="128.5mm" x="0mm" y="0mm" />
    #{circles_svg}
  </g>
</svg>
EOSVG


