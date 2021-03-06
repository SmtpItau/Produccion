USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROD_4x4_4x4]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PROD_4x4_4x4] ( @x11 FLOAT = 0.0,     -- x Matriz de 4 x 4
                                       @x12 FLOAT = 0.0,
                                       @x13 FLOAT = 0.0,
                                       @x14 FLOAT = 0.0,

				       @x21 FLOAT = 0.0,  -- 
                                       @x22 FLOAT = 0.0,
                                       @x23 FLOAT = 0.0,
                                       @x24 FLOAT = 0.0,

				       @x31 FLOAT = 0.0,  -- 
                                       @x32 FLOAT = 0.0,
                                       @x33 FLOAT = 0.0,
                                       @x34 FLOAT = 0.0,

				       @x41 FLOAT = 0.0,  -- 
                                       @x42 FLOAT = 0.0,
                                       @x43 FLOAT = 0.0,
                                       @x44 FLOAT = 0.0,

	  			       @y11 FLOAT = 0.0, -- Matriz y 4 x 4
				       @y12 FLOAT = 0.0,
	                               @y13 FLOAT = 0.0,
        	                       @y14 FLOAT = 0.0,

	  			       @y21 FLOAT = 0.0, 
				       @y22 FLOAT = 0.0,
	                               @y23 FLOAT = 0.0,
        	                       @y24 FLOAT = 0.0,

	  			       @y31 FLOAT = 0.0, -- Matriz
				       @y32 FLOAT = 0.0,
	                               @y33 FLOAT = 0.0,
        	                       @y34 FLOAT = 0.0,

	  			       @y41 FLOAT = 0.0, -- Matriz
				       @y42 FLOAT = 0.0,
	                               @y43 FLOAT = 0.0,
        	                       @y44 FLOAT = 0.0,

					
	  			       @r11 FLOAT = 0 output, -- Matriz Resultado R
				       @r12 FLOAT = 0 output,
	                               @r13 FLOAT = 0  output,
        	                       @r14 FLOAT = 0  output,

	  			       @r21 FLOAT  = 0 output, 
				       @r22 FLOAT  = 0 output,
	                               @r23 FLOAT  = 0 output,
        	                       @r24 FLOAT  = 0 output,

	  			       @r31 FLOAT  = 0 output, 
				       @r32 FLOAT  = 0 output,
	                               @r33 FLOAT  = 0 output,
        	                       @r34 FLOAT  = 0 output,

	  			       @r41 FLOAT  = 0 output, 
				       @r42 FLOAT  = 0 output,
	                               @r43 FLOAT  = 0 output,
        	                       @r44 FLOAT  = 0 output


             )
AS
BEGIN		

	select @r11 = @x11 * @y11 + @x12 * @y21 + @x13 * @y31 + @x14 * @y41 -- Fila 1 x, Columna 1 de y
	select @r12 = @x11 * @y12 + @x12 * @y22 + @x13 * @y32 + @x14 * @y42 -- Fila 1 x, Columna 2 de y
	select @r13 = @x11 * @y13 + @x12 * @y23 + @x13 * @y33 + @x14 * @y43 -- Fila 1 x, Columna 3 de y
	select @r14 = @x11 * @y14 + @x12 * @y24 + @x13 * @y34 + @x14 * @y44 -- Fila 1 x, Columna 4 de y


	select @r21 = @x21 * @y11 + @x22 * @y21 + @x23 * @y31 + @x24 * @y41 -- Fila 2 x, Columna 1 de y
	select @r22 = @x21 * @y12 + @x22 * @y22 + @x23 * @y32 + @x24 * @y42 -- Fila 2 x, Columna 2 de y
	select @r23 = @x21 * @y13 + @x22 * @y23 + @x23 * @y33 + @x24 * @y43 -- Fila 2 x, Columna 3 de y
	select @r24 = @x21 * @y14 + @x22 * @y24 + @x23 * @y34 + @x24 * @y44 -- Fila 2 x, Columna 4 de y


	select @r31 = @x31 * @y11 + @x32 * @y21 + @x33 * @y31 + @x34 * @y41 -- Fila 3 x, Columna 1 de y
	select @r32 = @x31 * @y12 + @x32 * @y22 + @x33 * @y32 + @x34 * @y42 -- Fila 3 x, Columna 2 de y
	select @r33 = @x31 * @y13 + @x32 * @y23 + @x33 * @y33 + @x34 * @y43 -- Fila 3 x, Columna 3 de y
	select @r34 = @x31 * @y14 + @x32 * @y24 + @x33 * @y34 + @x34 * @y44 -- Fila 3 x, Columna 4 de y


	select @r41 = @x41 * @y11 + @x42 * @y21 + @x43 * @y31 + @x44 * @y41 -- Fila 4 x, Columna 1 de y
	select @r42 = @x41 * @y12 + @x42 * @y22 + @x43 * @y32 + @x44 * @y42 -- Fila 4 x, Columna 2 de y
	select @r43 = @x41 * @y13 + @x42 * @y23 + @x43 * @y33 + @x44 * @y43 -- Fila 4 x, Columna 3 de y
	select @r44 = @x41 * @y14 + @x42 * @y24 + @x43 * @y34 + @x44 * @y44 -- Fila 4 x, Columna 4 de y
	
	SET NOCOUNT ON
	/*
	select @r11, @r12, @r13, @r14
	select @r21, @r22, @r23, @r24
	select @r31, @r32, @r33, @r34
	select @r41, @r42, @r43, @r44
	*/
END
GO
