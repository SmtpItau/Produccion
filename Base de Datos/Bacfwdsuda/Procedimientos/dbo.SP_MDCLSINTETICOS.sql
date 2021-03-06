USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLSINTETICOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDCLSINTETICOS]
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   SET ROWCOUNT 50
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
                   clapoderado                                
          FROM     VIEW_CLIENTE
          WHERE    clrut in (SELECT CONVERT(NUMERIC(9),clrut_hijo) 
    FROM VIEW_CLIENTE_RELACIONADO, MFAC
                                WHERE clrut_padre = acrutprop
       )
          ORDER BY clnombre
   SET ROWCOUNT 0
-- Ojo no existe en la tabla mdcl
--              clcompint                  ,
   /*=======================================================================*/
  SET NOCOUNT OFF
END

GO
