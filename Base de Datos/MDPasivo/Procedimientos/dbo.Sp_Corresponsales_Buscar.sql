USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Corresponsales_Buscar]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Corresponsales_Buscar]
   (   @rutcliente	NUMERIC(9)
   ,   @codigocliente	NUMERIC(9)
   )
AS			
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

	SELECT 'codigo_moneda'         =   isnull(codigo_moneda,0)
         ,     'codigo_pais'           =   isnull(codigo_pais,0)
         ,     'codigo_plaza'          =   isnull(codigo_plaza,0)
         ,     'codigo_swift,nombre'   =   isnull(codigo_swift,' ')
         ,     'nombre'                =   ISNULL(nombre,' ')
         ,     'cuenta_corriente'      =   isnull(cuenta_corriente,' ')
         ,     'swift_santiago'        =   isnull(swift_santiago,' ')
         ,     'banco_central'         =   isnull(banco_central,' ')
         ,     'fecha_vencimiento'     =   isnull(fecha_vencimiento,' ')
         ,     'DESCRIMONEDA'          =   ISNULL((SELECT MONEDA.mnnemo    FROM MONEDA  WHERE MONEDA.mncodmon    = CORRESPONSAL.codigo_moneda),' ')
         ,     'DESCRIPAIS'            =   ISNULL((SELECT PAIS.nombre      FROM PAIS    WHERE PAIS.codigo_pais   = CORRESPONSAL.codigo_pais),' ')
         ,     'DESCRIPLAZA'           =   ISNULL((SELECT PLAZA.glosa      FROM PLAZA   WHERE PLAZA.codigo_plaza = CORRESPONSAL.codigo_plaza),' ')
         ,     'NOMBRE'                =   ISNULL((SELECT CLIENTE.clnombre FROM CLIENTE WHERE CLIENTE.clrut      = @RUTCLIENTE AND CLIENTE.clcodigo = @codigocliente),' ')
         ,     'defecto'               =   isnull(defecto,' ')
         ,     'Codigo_contable'       =   isnull(codigo_corresponsal_contable,' ')
         FROM  CORRESPONSAL 
         WHERE rut_cliente    = @rutcliente  
         AND   codigo_cliente = @codigocliente  
		 
	SET NOCOUNT OFF

END



GO
