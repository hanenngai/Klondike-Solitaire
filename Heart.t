unit
class Heart
    %Inherits methods from Shape.t
    inherit Shape in "Shape.t"

    %Set color to red, width and height specified for use in the cards
    c := 12
    w := 20
    h := 25

    %Draws the heart shape
    body proc draw
	var x, y : array 1 .. 3 of int
	x (1) := cx - w div 2
	y (1) := cy + h div 8
	x (2) := cx + w div 2
	y (2) := cy + h div 8
	x (3) := cx
	y (3) := cy - h div 2
	Draw.FillPolygon(x, y, 3, c)
	Draw.FillArc(cx - w div 4, cy + h div 8, w div 4, h * 3 div 8, 0, 180, c)
	Draw.FillArc(cx + w div 4, cy + h div 8, w div 4, h * 3 div 8, 0, 180, c) 
    end draw
end Heart
