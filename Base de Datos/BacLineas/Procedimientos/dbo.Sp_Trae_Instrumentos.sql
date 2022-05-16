USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Instrumentos]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Trae_Instrumentos    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Trae_Instrumentos    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[Sp_Trae_Instrumentos](@xSerie  CHAR(12))
AS
BEGIN
set nocount on
SELECT  inserie  ,  --1
 inglosa  ,  --2
 incodigo ,  --3
 inprog  ,  --4
 inrefnomi ,  --5
 inrutemi ,  --6
 inmonemi ,  --7
 inbasemi ,  --8
 intasest ,  --9
 intipo  ,  --10
 inmdse  ,  --11
 inmdpr  ,  --12
 inmdtd  ,  --13
 intipfec  , --14
 inemision ,  --15
 ineleg  ,  --16
 incontab ,             --17
        insecuritytype  ,               --18         
        intotalemitido  ,               --19 
        insecuritytype2 ,               --20
        intiporig                       --21  
 FROM INSTRUMENTO
 WHERE  inserie  = @xserie
set nocount off
END
--Sp_Trae_Instrumentos 'PRC'






GO
