USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_FUTURO1446]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_FUTURO1446] (
                                       @numoper numeric(19)
                                      )
AS
begin 
 select motipmer,momonmo,moticam,monomcli,morutcli,mocodcli,motipope,monumope
       from memo 
            where monumope = @numoper and (motipmer = 'CUPO' or motipmer = 'ARRI' or motipmer ='1446'or motipmer = 'FUTU')
End



GO
