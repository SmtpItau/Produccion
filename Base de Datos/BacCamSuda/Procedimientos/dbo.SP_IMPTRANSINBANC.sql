USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPTRANSINBANC]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPTRANSINBANC]
        (@tip char(1))
AS                            
BEGIN
set nocount on
  declare @consult varchar(255)
IF @tip='7' BEGIN
  SELECT @CONSULT ='SELECT  *   FROM #temp order by tipoopera+str(noopera)'
end
else begin
  SELECT @CONSULT ='SELECT  *   FROM #temp  order by tipoopera+nombrecliente+str(noopera)'
end
       select     'rutemisor'=0,
                  'codigoemisor'=0,
                  'nombreemisor'=space(40),
                  'nombrecliente'=a.clnombre,
                  'direccioncliente'=a.cldirecc,
                  'tacfecpro' =space(10) ,
                  'noopera'=          monumope,
                  'tipoopera'=        motipope,
                  'montoclp'=         momonpe,
                  'montousd'=         moussme,
                  'tipocamcie'=       moticam,
                  'recib'=            b.glosa2,
                  'entreg'=           c.glosa2,
                  'digchkemisor'=space(1) 
      INTO #temp
  
      FROM    MEMO , VIEW_CLIENTE A , VIEW_FORMA_DE_PAGO B, VIEW_FORMA_DE_PAGO C 
                                         
      WHERE   morutcli=a.clrut AND mocodcli =a.clcodigo AND morecib=b.codigo AND 
              moentre=c.codigo AND motipmer='PTAS' 
      UPDATE   #temp
    
      set      tacfecpro=convert(char(10),acfecpro,101), 
               rutemisor=acrut ,
               codigoemisor=accodigo, 
               digchkemisor=acdv,
               nombreemisor=acnombre  
      FROM MEAC
		set nocount off
 END

GO
