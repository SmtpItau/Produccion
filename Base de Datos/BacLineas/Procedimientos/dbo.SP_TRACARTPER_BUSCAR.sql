USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRACARTPER_BUSCAR]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TRACARTPER_BUSCAR    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[SP_TRACARTPER_BUSCAR] 
 AS BEGIN
 SELECT  cpnumdocu,cpcorrela,cprutcli,cpcodcli,cpmascara,cpnominal,cpfeccomp,cpvalcomp,cpvalcomu,cptircomp,cpvptirc 
 FROM VIEW_MDCP WHERE codigo_carterasuper='T' 
 END
GO
