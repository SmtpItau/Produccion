USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[carolina1]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[carolina1]
as select * from mfcares   where cafechaproceso='20100505'

GO
