USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_VALORMONEDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Grabar_ValorMoneda    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Grabar_ValorMoneda    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_GRABAR_VALORMONEDA]( @vmcodmon INTEGER ,
                                        @vmvalor  FLOAT   ,
                                        @vmfecha  CHAR(8) )
AS   
BEGIN 
     IF EXISTS (SELECT 1 FROM VALOR_MONEDA WHERE vmcodigo = @vmcodmon AND vmfecha = @vmfecha)
     BEGIN
          UPDATE VALOR_MONEDA
             SET vmvalor  = @vmvalor
           WHERE vmcodigo = @vmcodmon
             AND vmfecha  = @vmfecha
         
          IF @@ERROR <> 0   BEGIN
             SELECT -1, 'ERROR no se pudo Actualizar Valor'
             RETURN 1
          END
     END ELSE BEGIN
        
          INSERT VALOR_MONEDA( vmcodigo ,
                       vmvalor  ,
                       vmfecha  ,
                       vmptavta ,
                       vmptacmp )
              VALUES( @vmcodmon ,
                      @vmvalor  ,
                      @vmfecha  ,
                      0         ,
                      0         )
    
          IF @@ERROR <> 0   BEGIN
             SELECT -1, 'ERROR no se pudo Agregar Valor'
             RETURN 1
          END
     END
END  -- PROCEDURE

GO
