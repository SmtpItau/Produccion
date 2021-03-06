USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDCLleerRut1]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create procedure [dbo].[Sp_MDCLleerRut1] (    @clrut numeric(10),
        				  @clcodigo numeric(10))
as
begin
	set nocount off
        SET DATEFORMAT dmy

	select     
   	clrut ,
      	cldv,
      	clcodigo,
      	clnombre,
      	clgeneric,
      	cldirecc, 
      	clcomuna, 
      	clregion, 
      	clfecingr,
      	clctacte, 
      	clfono, 
      	clfax, 
      	cltipcli, 
      	clcalidadjuridica,
      	clciudad, 
      	clmercado,
      	clpais, 
      	clcodigo,
      	'clNumSinacofi'= ISNULL((select isnull(clnumsinacofi,0) from sinacofi where clrut= @clrut and clcodigo=@clcodigo),0),
      	'clNomSinacofi'= ISNULL((select isnull(clnomsinacofi,0) from sinacofi where clrut= @clrut and clcodigo=@clcodigo),0),
	'cldatatec'=ISNULL((select isnull(datatec,' ') from sinacofi            where clrut= @clrut and clcodigo=@clcodigo),' '),
	'clbolsa'=ISNULL((select isnull (bolsa,' ') from sinacofi               where clrut= @clrut and clcodigo=@clcodigo),' '),
        'clCuenta_DCV'=ISNULL((select isnull (Cuenta_Dcv,' ') from sinacofi     where clrut= @clrut and clcodigo=@clcodigo),' '),
	'nombre_cliente_datatec' = ISNULL((select isnull (nombre_cliente_datatec,' ') from sinacofi     where clrut= @clrut and clcodigo=@clcodigo),' ')
	from CLIENTE 
	where clrut= @clrut and clcodigo=@clcodigo
	
   	set nocount off   
end     



GO
