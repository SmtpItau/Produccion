USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[CR1]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- select * from CR1
--sp_helptext CR1
-- drop view dbo.CR1

create view [dbo].[CR1]
as

select * FROM   bacfwdsuda.dbo.mfcah WHERE  cafecvcto = '20120809' AND cacodpos1 = 2 AND catipmoda = 'E'
GO
