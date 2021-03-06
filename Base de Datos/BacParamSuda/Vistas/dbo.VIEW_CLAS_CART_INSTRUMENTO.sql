USE [BacParamSuda]
GO
/****** Object:  View [dbo].[VIEW_CLAS_CART_INSTRUMENTO]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_CLAS_CART_INSTRUMENTO]
AS

   SELECT id_Sistema     , Tipo_movimiento,Tipo_operacion
        , TipoInstrumento, Moneda,         TipoEmisor
        , OrigenEmision  , ObjetoCubierto, Contraparte,Desde,Hasta,CarteraNormativa,SubcarteraNormativa,Glosa,CodigoCartera
     FROM BacParamSuda.dbo.TBL_CLASIFICACION_CARTERA_INSTRUMENTO
GO
