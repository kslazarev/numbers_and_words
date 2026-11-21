# frozen_string_literal: true

module Logo
  # Converts TrueType contours to SVG path data, with quadratic curves between on-curve points.
  module Outline
    module_function

    def path(contours)
      contours.map { |points| contour(points) }.join
    end

    def contour(points)
      points = start_on_curve(points)
      commands = ["M#{pair(points.first)}"]
      control = nil
      (points.drop(1) + [points.first]).each { |point| control = step(commands, control, point) }
      "#{commands.join}Z"
    end

    def start_on_curve(points)
      on = points.index { |point| point[2] }
      on ? points.rotate(on) : [midpoint(points.last, points.first), *points]
    end

    # Adds the command that reaches point and returns the pending off-curve control point, if any.
    def step(commands, control, point)
      if point[2]
        commands << (control ? "Q#{pair(control)} #{pair(point)}" : "L#{pair(point)}")
        return nil
      end
      commands << "Q#{pair(control)} #{pair(midpoint(control, point))}" if control
      point
    end

    def midpoint(from, to)
      [(from[0] + to[0]) / 2.0, (from[1] + to[1]) / 2.0, true]
    end

    def pair(point)
      point.first(2).map { |value| number(value) }.join(' ')
    end

    def number(value)
      rounded = value.round(2)
      rounded == rounded.to_i ? rounded.to_i.to_s : rounded.to_s
    end
  end
end
