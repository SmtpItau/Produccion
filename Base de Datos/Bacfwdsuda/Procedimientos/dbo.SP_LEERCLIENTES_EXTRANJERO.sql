USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCLIENTES_EXTRANJERO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERCLIENTES_EXTRANJERO]
	(	@cnombre	CHAR(40)	)
AS
BEGIN

   SET NOCOUNT ON

   /*=======================================================================*/
   SELECT          clrut                                      ,
                   cldv                                       ,
                   clcodigo                                   ,
                   clnombre                                   ,
                   clgeneric                                  ,
                   cldirecc                                   ,
                   clcomuna                                   ,
                   clregion                                   ,
                   cltipcli                                   ,
                   CONVERT( CHAR(10), clfecingr, 103 )        ,
                   clctacte                                   ,
                   clfono                                     ,
                   clfax                                      ,
                   0                             ,
                   clcalidadjuridica                          ,
                   clciudad                                   ,
                   clentidad                                  ,
                   clmercado                                  ,
                   clgrupo                                    ,
                   clapoderado                                ,
		   fecha_escritura			      ,
		   nombre_notaria			      ,
		   clFechaFirma_cond
          FROM     BacParamSuda..Cliente with(nolock)
          WHERE    cltipcli = 2	
	  and      clVigente = 'S'
	  and      clnombre LIKE LTRIM(RTRIM( @cnombre )) + '%'
          ORDER BY clnombre

END
GO
