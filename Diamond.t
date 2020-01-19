unit
class Diamond
    %Inherits methods from Shape.t
    inherit Shape in "Shape.t"

    %Set color to red, width and height specified for use in the cards
    c := 12
    w := 20
    h := 25
    
    %Draws the diamond shape
    body proc draw
	Draw.Line (cx + w div 2, cy, cx, cy + h div 2, c)
	Draw.Line (cx + w div 2, cy, cx, cy - h div 2, c)
	Draw.Line (cx - w div 2, cy, cx, cy + h div 2, c)
	Draw.Line (cx - w div 2, cy, cx, cy - h div 2, c)
	Draw.Fill (cx, cy, c, c)
    end draw
end Diamond
