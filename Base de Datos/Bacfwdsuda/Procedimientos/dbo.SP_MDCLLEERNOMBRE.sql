USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERNOMBRE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDCLLEERNOMBRE]
       (
        @cnombre     CHAR(40)          -- Generico del Cliente
       )
AS
BEGIN

   SET NOCOUNT ON

   SET ROWCOUNT 1000

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
          FROM     BacParamSuda..Cliente
          WHERE    clnombre like ltrim(rtrim(@cnombre)) + '%'
	  AND 	   clvigente = 'S'
          ORDER BY clnombre

   SET ROWCOUNT 0

   SET NOCOUNT OFF
END
GO
