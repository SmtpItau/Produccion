USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERRUT1]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MDCLleerRut1    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
CREATE PROCEDURE [dbo].[SP_MDCLLEERRUT1] (@clrut numeric(10),
      @clcodigo numeric(10))
as
begin
 set nocount off
 select     
    clrut ,
       cldv,
       clcodigo,
       clnombre,
       clgeneric,
       cldirecc, 
       clcomuna, 
       clregion, 
       clcompint,
       clfecingr,
       clctacte, 
       clfono, 
       clfax, 
       cltipcli, 
       clcalidadjuridica,
       clciudad, 
       clentidad, 
       clmercado,
       clgrupo,
       clapoderado,
       clpais, 
       clcodigo,
       'clNumSinacofi'=(select isnull(clnumsinacofi,'') from sinacofi where clrut= @clrut and clcodigo=@clcodigo),
       'clNomSinacofi'=(select isnull(clnomsinacofi,'') from sinacofi where clrut= @clrut and clcodigo=@clcodigo),
 'cldatatec'=(select isnull(datatec,'') from sinacofi where clrut= @clrut and clcodigo=@clcodigo),
 'clbolsa'=(select isnull (bolsa,'') from sinacofi where clrut= @clrut and clcodigo=@clcodigo)
 from CLIENTE 
 where clrut= @clrut and clcodigo=@clcodigo
 
    set nocount off   
end     

GO
