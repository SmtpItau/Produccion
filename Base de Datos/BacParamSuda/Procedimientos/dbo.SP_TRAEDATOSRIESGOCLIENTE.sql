USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEDATOSRIESGOCLIENTE]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TRAEDATOSRIESGOCLIENTE]
   (   @RutCliente	NUMERIC(14)
   ,   @CodCliente	NUMERIC(9) 
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT clrut			= cl.Clrut
   ,      cldv			= cl.Cldv
   ,      clcodigo		= cl.ClCodigo
   ,      clnombre		= cl.Clnombre
   ,      clclsbif		= cl.Clclsbif
   ,      seg_comercial		= ISNULL(SgmCod, 0)--PRD-8800
   ,      det_seg_comercial	= ISNULL(SgmDesc, '')--PRD-8800
   ,      ejecutivo_comercial	= cl.ejecutivo_comercial
   FROM   Bacparamsuda.dbo.CLIENTE cl                             with(nolock) 
          LEFT JOIN Bacparamsuda.dbo.TBL_SEGMENTOSCOMERCIALES segcom with(nolock) ON  segcom.SgmCod = cl.seg_comercial 
										--PRD-8800 segcom.tbcateg   = 8020
                                                                             
   WHERE  cl.Clrut    = @RutCliente
   AND	  cl.ClCodigo = @CodCliente

END

GO
