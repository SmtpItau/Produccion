USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_General_Lee_Moneda]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_General_Lee_Moneda]
              
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

      SELECT 
          mnglosa
         ,mnnemo
         ,mnrrda
         ,mncodmon
      FROM 
         MONEDA

      WHERE 
         mnmx = 'C'
         AND ESTADO<>'A'

   SET NOCOUNT OFF

END


GO
