USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCEOPERACIONESVIG_TURING_OPERADORES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CALCEOPERACIONESVIG_TURING_OPERADORES] 
AS  
BEGIN  
   SET NOCOUNT ON  
      select distinct caoperador from mfca
END
GO
