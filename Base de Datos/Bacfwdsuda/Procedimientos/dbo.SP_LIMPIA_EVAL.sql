USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_EVAL]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LIMPIA_EVAL](  @Rut_Cliente       NUMERIC (9,0)
                                         ,@Codigo_Cliente    NUMERIC (9,0)
)

AS
BEGIN 

 delete from Bacfwdsuda..mfmo where monumoper in(select canumoper from Bacfwdsuda..mfca_eval WHERE cacodigo =@Rut_Cliente
												    AND cacodcli=@Codigo_Cliente
											    )

 DELETE FROM Bacfwdsuda..mfca_eval WHERE cacodigo =@Rut_Cliente
                                   AND cacodcli=@Codigo_Cliente


END

GO
