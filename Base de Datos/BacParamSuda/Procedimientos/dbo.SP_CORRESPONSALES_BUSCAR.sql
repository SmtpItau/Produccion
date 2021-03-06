USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_BUSCAR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_BUSCAR]
   (   @rutcliente  NUMERIC(9) 
   ,   @codigocliente  NUMERIC(5)
   )
AS   
BEGIN

   SET NOCOUNT ON

   SELECT codigo_moneda  , --1
          codigo_pais  , --2
          codigo_plaza  , --3
          codigo_swift  , --4
          nombre   , --5
          cuenta_corriente , --6
          swift_santiago  , --7
          banco_central  , --8
          fecha_vencimiento , --9
          'DESCRIMONEDA'=(SELECT MONEDA.mnnemo FROM MONEDA WHERE MONEDA.mncodmon= CORRESPONSAL.codigo_moneda) ,
          'DESCRIPAIS'=(SELECT PAIS.nombre FROM PAIS WHERE PAIS.codigo_pais = CORRESPONSAL.codigo_pais)  ,
          'DESCRIPLAZA'=(SELECT PLAZA.glosa FROM PLAZA WHERE PLAZA.codigo_plaza = CORRESPONSAL.codigo_plaza) ,
          'NOMBRE'=(SELECT CLIENTE.clnombre FROM CLIENTE WHERE CLIENTE.clrut=@RUTCLIENTE AND CLIENTE.clcodigo = @codigocliente) ,
          codigo_corres  , --14
          codigo_contable  , --15
          cod_corresponsal , --16
          Rut_Corresponsal  --17
   FROM   CORRESPONSAL 
   WHERE  rut_cliente = @rutcliente  
   AND    codigo_cliente = @codigocliente  
   ORDER BY codigo_moneda, CORRESPONSAL.nombre, codigo_pais, codigo_plaza

 SET NOCOUNT OFF       
END        
GO
