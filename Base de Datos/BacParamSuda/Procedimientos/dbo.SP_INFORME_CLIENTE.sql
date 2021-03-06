USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CLIENTE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_CLIENTE]
AS
BEGIN 
declare @entidad char(20)
SET NOCOUNT ON
select  @entidad = acnomprop from VIEW_MDAC
 IF EXISTS( select acnomprop FROM CLIENTE,VIEW_MDAC
            WHERE clfecingr=acfecproc) begin 
   SELECT  rut = CONVERT(CHAR(10),clrut)+'-'+cldv ,
   clcodigo     ,
   clnombre     ,
   tipo = (SELECT tbglosa FROM TABLA_GENERAL_DETALLE WHERE tbcateg=72 AND tbcodigo1=cltipcli),
   'entidad'= @entidad,
   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) 
   FROM CLIENTE,VIEW_MDAC
  WHERE clfecingr=acfecproc
end else begin 
SELECT  'rut' = '',
   'clcodigo'='',
   'clnombre'='',
   'tipo' ='',
   'entidad'=@entidad 
end
 SET NOCOUNT OFF
END


GO
