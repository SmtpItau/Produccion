USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONTO_EXCEDIDOS_OPER]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_MONTO_EXCEDIDOS_OPER]
AS 
BEGIN
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop
  FROM VIEW_MDAC                
IF EXISTS (SELECT * FROM LINEA_TRASPASO   A,
                         LINEA_TRANSACCION B,
                         PRODUCTO C
--    BACTRADERSUDA..MDAC D
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
           ,'MONTOTRASPASODO'  = A.MONTOTRASPASADO
           ,'AUTORIZADO'       = A.USUARIOAUTORIZO
           ,'FECHAINICIO'      = CONVERT(CHAR(10),A.FECHAINICIO,103)
           ,'FECHAVENCIMIENTO' = CONVERT(CHAR(10),A.FECHAVENCIMIENTO,103)
           ,'HORA'             = A.HORA_TRASPASO
    ,'hora reporte'     = convert(char(8),getdate(),108)
 
    ,'BANCO'        = d.ACNOMPROP
      ,'FECHA PROCESO'    = D.ACFECPROC
 FROM 
      LINEA_TRASPASO    A,
      LINEA_TRANSACCION  B,
      PRODUCTO C,
      BACTRADERSUDA..MDAC D
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
    ,'hora reporte'  =  convert(char(8),getdate(),108)
    ,'BANCO'     = (SELECT ACNOMPROP FROM BACTRADERSUDA..MDAC)
    ,'FECHA PROCESO' = (SELECT ACFECPROC FROM BACTRADERSUDA..MDAC)
END
END

GO
