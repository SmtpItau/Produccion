USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_CLIENTE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAR_CLIENTE]
    (
    @nRut   NUMERIC  (10)  ,
    @cDv   CHAR   (01)  ,
    @nCodigo  NUMERIC  (5)  ,
    @cNombre  CHAR   (70)  ,
    @nTipo   NUMERIC  (05)  ,
    @dFecpro  DATETIME  ,
    @cnombre1 CHAR   (20)  ,
    @cnombre2 CHAR   (20)  ,
    @apellido1 CHAR   (20)  ,
    @apellido2 CHAR   (20)  ,
    @opcion CHAR   (1)  ,
    @fono CHAR  (20)
    )
AS
BEGIN
SET NOCOUNT ON
INSERT INTO
VIEW_CLIENTE
  (
  clrut   ,
  cldv   ,
  clcodigo  ,
  clnombre  ,
  cltipcli  ,
  Clfecingr ,
  clnomb1       ,
  clnomb2       ,
  clapelpa  ,
  clapelma  ,
  clopcion ,
  clfono
) 
 VALUES
  (
  @nRut   ,
  @cDv   ,
  @nCodigo  ,
  @cNombre  ,
  @nTipo   ,
  @dFecpro ,
  @cnombre1 ,
  @cnombre2 ,
  @apellido1 ,
  @apellido2 ,
  @opcion ,
  @fono  
 )
 SELECT 'OK' 
 SET NOCOUNT OFF
END
-- select * from VIEW_CLIENTE WHERE clrut = 12507903
-- Sp_Grabar_Cliente 12507903, '2', '1', 'JOHAN  CHAVARRIA', 8, '20020102'

GO
