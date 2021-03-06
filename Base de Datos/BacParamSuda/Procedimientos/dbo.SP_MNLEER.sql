USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNLEER]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNLEER]
   (   @mncodmon1   NUMERIC(3,0)   )
AS
BEGIN
   SET NOCOUNT ON

   SELECT /*001*/ mncodmon
   ,      /*002*/ mnnemo
   ,      /*003*/ mnsimbol
   ,      /*004*/ mnglosa
   ,      /*005*/ mnredondeo
   ,      /*006*/ mnbase
   ,      /*007*/ mntipmon
   ,      /*008*/ mncodbanco
   ,      /*009*/ mnperiodo
   ,      /*010*/ mncodsuper
   ,      /*011*/ mncodfox
   ,      /*012*/ codigo_pais
   ,      /*013*/ mncodcor
   ,      /*014*/ mnextranj
   ,      /*015*/ mnrefmerc
   ,      /*016*/ mnrefusd
   ,      /*017*/ mnlimite
   ,      /*018*/ mncodcorrespC
   ,      /*019*/ mncodcorrespV
   ,      /*020*/ mnctacamb
   ,      /*021*/ mncanasta
   ,      /*022*/ mniso_coddes
   ,      /*023*/ mncodBancoC
   ,      /*024*/ mncodBancoV
   ,      /*025*/ MnCodDcv
   ,	  /*026*/ mningval			--> PRD-16772
   ,	  /*027*/ mnsinacofi		--> LD1-COR-035-Configuración BAC Corpbanca, Tema: Interfaz TCRC917-TCRC915
   ,	  /*028*/ mncodbkb			--> LD1_035_IDD
   FROM   BacParamSuda.dbo.MONEDA
   WHERE  mncodmon = @mncodmon1

   RETURN
END

GO
