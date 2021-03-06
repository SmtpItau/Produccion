USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INVEX_MONEDASDISPONIBLES]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_INVEX_MONEDASDISPONIBLES] 
AS
BEGIN

SET NOCOUNT ON				
 
  select 
  distinct 'Nemotecnico'= b.mnnemo ,
	   'Codigo'	= a.cpmonemi	
  from  TEXT_CTR_INV a,
	VIEW_MONEDA  b,
	text_arc_ctl_dri
  where  b.mncodmon = a.cpmonemi
  AND	cpfecpago <= acfecproc
  AND	cpnominal > 0

SET NOCOUNT OFF
  
END

GO
