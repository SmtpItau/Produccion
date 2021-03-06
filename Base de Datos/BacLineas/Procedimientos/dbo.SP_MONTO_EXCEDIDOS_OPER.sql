USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONTO_EXCEDIDOS_OPER]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[SP_MONTO_EXCEDIDOS_OPER]
AS 
BEGIN
IF EXISTS (SELECT * FROM LINEA_TRASPASO   A,
                         LINEA_TRANSACCION B,
                         PRODUCTO C
--			 HSBCRENTAFIJA..MDAC D

                     WHERE A.NUMEROOPERACION   = B.NUMEROOPERACION
                     AND   A.NUMERODOCUMENTO   = B.NUMERODOCUMENTO
                     AND   A.NUMEROCORRELATIVO = B.NUMEROCORRELATIVO
                     AND   C.CODIGO_PRODUCTO   = A.CODIGO_PRODUCTO
		     
   )

BEGIN
SELECT
            'OPERACION'        = A.CODIGO_PRODUCTO
           ,'OPERADOR'         = A.OPERADOR
           ,'MAXPOROPER'       = B.MONTOORIGINAL
           ,'MONTOTRASPASADO'  = A.MONTOTRASPASADO
           ,'AUTORIZADO'       = A.USUARIOAUTORIZO
           ,'FECHAINICIO'      = CONVERT(CHAR(10),A.FECHAINICIO,103)
           ,'FECHAVENCIMIENTO' = CONVERT(CHAR(10),A.FECHAVENCIMIENTO,103)
           ,'HORA'             = A.HORA_TRASPASO
	   ,"hora reporte"     = convert(char(8),getdate(),108)
	   ,"FECHA PROCESO"    = D.ACFECPROC
 	     
FROM 
      LINEA_TRASPASO    A,
      LINEA_TRANSACCION  B,
      PRODUCTO C,
      BACTRADFALA..MDAC D

WHERE

    A.NUMEROOPERACION   = B.NUMEROOPERACION
AND A.NUMERODOCUMENTO   = B.NUMERODOCUMENTO
AND A.NUMEROCORRELATIVO = B.NUMEROCORRELATIVO
AND C.CODIGO_PRODUCTO   = A.CODIGO_PRODUCTO      

END 
ELSE
BEGIN

    SELECT 
            'OPERACION'        = ''
           ,'OPERADOR'         = ''
           ,'MAXPOROPER'       = 0
           ,'MONTOTRASPASADO'  = 0
           ,'AUTORIZADO'       = ''
           ,'FECHAINICIO'      = ''
           ,'FECHAVENCIMIENTO' = ''
           ,'HORA'             = ''
	   ,"hora reporte"  =  convert(char(8),getdate(),108)
	   ,"FECHA PROCESO" = (SELECT ACFECPROC FROM BACTRADFALA..MDAC)
	   ,'nombreentidad' = (SELECT ACNOMPROP FROM BACTRADFALA..MDAC)	

END
END







GO
