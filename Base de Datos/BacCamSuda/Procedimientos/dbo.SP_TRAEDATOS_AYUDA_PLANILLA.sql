USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEDATOS_AYUDA_PLANILLA]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TRAEDATOS_AYUDA_PLANILLA](  
                                                   @codigo_tabla     NUMERIC(10,0) = 00
                                                  ,@xcodigo_caracter CHAR   (10)   = ''
                                                  ,@xcodigo_numerico NUMERIC(10)   = 0
                                                  ,@sw               NUMERIC(1) 
                                                )
AS
BEGIN
      IF @xcodigo_caracter = '' AND @xcodigo_numerico = 0 BEGIN
         SELECT codigo_numerico,codigo_caracter,glosa
         FROM   view_ayuda_planilla 
         WHERE  codigo_tabla    = @codigo_tabla
           AND  codigo_numerico <> 0
           AND  codigo_caracter <> '0'
      END 
      ELSE BEGIN
      
         IF @sw = 1 BEGIN   
            SELECT codigo_numerico,codigo_caracter,glosa
            FROM   view_ayuda_planilla 
            WHERE  codigo_tabla    = @codigo_tabla
              AND  codigo_numerico = @xcodigo_numerico
         END 
         ELSE BEGIN
                  SELECT codigo_numerico,codigo_caracter,glosa
                  FROM   view_ayuda_planilla 
                  WHERE  codigo_tabla    = @codigo_tabla
                   AND   codigo_caracter = @xcodigo_caracter
              End
      END
END





GO
