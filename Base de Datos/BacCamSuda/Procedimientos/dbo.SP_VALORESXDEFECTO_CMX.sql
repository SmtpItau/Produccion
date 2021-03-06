USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORESXDEFECTO_CMX]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SP_VALORESXDEFECTO_CMX]
            ( 
               @entidad  CHAR(2) ,
		@Clase  char(2),
		@valor numeric(18,4)
		
            )
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @rut NUMERIC(10)
	SELECT  @rut = acrutprop FROM VIEW_MDAC

 
  SELECT acposini,
           acpreini,
           acposic,
           actotco,
           acpmeco,
           actotve,
           acpmeve,
           acutili,
           acutilipo,
           acutiltot,
           case when @clase= 'OC' then  @valor  else
		accoscomp
	  end,
           @valor ,
           acultpta,
           acultmon,
           acultpre,
           acobser,
           'rut' = @rut,
           accband,
           acvband,
           acmtoptas,
           acfprptac,
           acfpeptac,
           acfprptav,
           acfpeptav,
           acfprempc,
           acfpeempc,
           acfprempv,
           acfpeempv,
           acomacpta,
           acrentabp,
           acmoneda,
           acomavpta,
           1,
           acrentab,
           acomac,
           acomav
      FROM MEAC
--          ,Valor_defecto
     WHERE acentida = @entidad
END









GO
