USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERGENERIC]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDCLLEERGENERIC]
       (
        @cgeneric    CHAR(40)          -- Generico del Cliente
       )
AS
BEGIN
SET NOCOUNT ON
 DECLARE @rut NUMERIC(10) ,
  @codigo NUMERIC(10)
 SELECT @rut = clarutcli ,
  @codigo = clacodigo
 FROM view_abreviatura_cliente
 WHERE claglosa = @cgeneric
 
 IF @rut <> 0 
  BEGIN
   SELECT a.clrut                                         , -- 1
    a.cldv                                          , -- 2
    a.clcodigo                                      , -- 3
    a.clnombre                                      , -- 4
    @cgeneric     , -- 5
    a.cldirecc                                      , -- 6
    a.clcomuna                                      , -- 7
    a.clregion                                      , -- 8
    a.cltipcli                                      , -- 9
    CONVERT( CHAR(10), a.clfecingr, 103 )           , -- 10
    a.clctacte                                      , -- 11
    a.clfono                                        , -- 12
    a.clfax                                         , -- 13
    0                                               , -- 14
    a.clcalidadjuridica                             , -- 15
    a.clciudad                                      , -- 16
    a.clentidad                                     , -- 17
    a.clmercado                                     , -- 18
    a.clgrupo                                       , -- 19
    a.clapoderado                                   , -- 20
    a.clpais                                        , -- 21
    'clnumsinacofi' = ISNULL(b.clnumsinacofi,'0000'), -- 22
    'clnomsinacofi' = ISNULL(b.clnomsinacofi,'')    , -- 23
    'Remunera_Linea' = ISNULL(c.remuneracion_linea,0), -- 24
    a.clvigente					       -- 25				
   

   /*FROM   BacParamSuda..Cliente       a,
    VIEW_TBSINACOFI  b,
    VIEW_LINEA_GENERAL c
   WHERE  ( @rut  = a.clrut 
    AND @codigo = a.clcodigo )
    AND ( b.clrut      =* a.clrut
    AND b.clcodigo   =* a.clcodigo )
    AND ( c.rut_cliente    =* a.clrut
    AND c.codigo_cliente =* a.clcodigo ) */
	--RQ 7619
   FROM   BacParamSuda..Cliente a LEFT OUTER JOIN VIEW_TBSINACOFI  b 
				      ON (  a.clrut = b.clrut AND  a.clcodigo=b.clcodigo  )
				  LEFT OUTER JOIN VIEW_LINEA_GENERAL c 
				      ON ( a.clrut = c.rut_cliente  AND a.clcodigo = c.codigo_cliente )
   
   WHERE	( @rut  = a.clrut 
   AND		@codigo = a.clcodigo )
    
   


  END
   SET NOCOUNT OFF
END

GO
