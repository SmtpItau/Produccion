USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LISTAMONEDAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Cnt_ListaMonedas    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Cnt_ListaMonedas    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[SP_CNT_LISTAMONEDAS] 
         (@paresid_sistemas CHAR(03))
AS
BEGIN
        SET NOCOUNT ON
 DECLARE @varorgmonedas  CHAR(60)
 DECLARE @vardatamonedas CHAR(60)
        DECLARE @cond_monedas CHAR(60)
 IF  EXISTS( SELECT 1 FROM PRODUCTO_CNT WHERE id_sistema = @paresid_sistemas )
 BEGIN
 
            SELECT @varorgmonedas   = origen_monedas , 
        @vardatamonedas  = datos_monedas  ,
                   @cond_monedas    = cond_monedas
              FROM PRODUCTO_CNT 
             WHERE id_sistema = @paresid_sistemas
     IF RTRIM(@cond_monedas  ) <> ''
               SELECT @cond_monedas = 'WHERE ' + @cond_monedas
            IF RTRIM(@vardatamonedas) <> '' 
               EXECUTE ( 'SELECT ' + @vardatamonedas + ' FROM ' + @varorgmonedas + @cond_monedas )
 END
 ELSE
 BEGIN
            SELECT 'NO HAY DATOS' 
 END
END
GO
