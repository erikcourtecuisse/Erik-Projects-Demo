DRAW_RECT:
    MOVE #90,D0
    TRAP #15
    RTS
    
DRAW_LINE:
    MOVE #84,D0
    TRAP #15
    RTS

DRAW_PIX:
    MOVE #82,D0
    TRAP #15
    RTS
    
SET_PEN_COLOR:
    MOVE #80,D0
    TRAP #15
    RTS

SET_FILL_COLOR:
    MOVE #81,D0
    TRAP #15
    RTS
    
POT_DE_PEINTURE:
    MOVE #89,D0
    TRAP #15
    RTS
    
DRAW_ELLIPSE:
    MOVE #91,D0
    TRAP #15
    RTS
    

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
