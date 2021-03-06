USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HIPOTECARIA_VALIDA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_HIPOTECARIA_VALIDA] 
     (
      @rut_cliente NUMERIC (09,0),
      @dv_cliente  CHAR    (01)
     )
AS
BEGIN
IF EXISTS ( SELECT 1 FROM LETRA_HIPOTECARIA_CLIENTE WHERE rut_cliente = @rut_cliente AND dv = @dv_cliente )
BEGIN
 
  SELECT 
       nombre
      ,rut_cliente
      ,codigo_cliente --=@codigo_cliente
      ,codigo_pais
      ,codigo_region 
      ,codigo_ciudad 
      ,codigo_comuna 
      ,direccion      --=@direc_cliente
      ,telefono       --=@telefono_cliente
      ,fax            --=@fax_cliente
      ,email          --=@email_cliente
      ,dv
   FROM LETRA_HIPOTECARIA_CLIENTE      
   WHERE  rut_cliente = @rut_cliente
     AND dv = @dv_cliente 
END
ELSE
BEGIN
   SELECT 'NO EXISTE'
END
END
-- l.codigo_ciudad


GO
