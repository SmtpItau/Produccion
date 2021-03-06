USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PASO_ACTULIZA_SERIE]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PASO_ACTULIZA_SERIE]
as
begin
 UPDATE mdcp set cpinstser = 'SUD0200601' WHERE cpinstser = 'SUD020 &06'
 UPDATE mdcp set cpinstser = 'SUD0260601' WHERE cpinstser = 'SUD026 &06'
 UPDATE mdcp set cpinstser = 'SUD0270601' WHERE cpinstser = 'SUD027 &06'
 UPDATE mdcp set cpinstser = 'SUD0280601' WHERE cpinstser = 'SUD028 &06'
 UPDATE mdcp set cpinstser = 'SUD0290601' WHERE cpinstser = 'SUD029 &06'
 UPDATE mdcp set cpinstser = 'SUD0300601' WHERE cpinstser = 'SUD030 &06'
 UPDATE mdcp set cpinstser = 'SUD0330601' WHERE cpinstser = 'SUD033 &06'
 UPDATE mdcp set cpinstser = 'SUD0340601' WHERE cpinstser = 'SUD034 &06'
 UPDATE mdcp set cpinstser = 'SUD0350601' WHERE cpinstser = 'SUD035 &06'
 UPDATE mdcp set cpinstser = 'SUD0360601' WHERE cpinstser = 'SUD036 &06'
 UPDATE mdcp set cpinstser = 'SUD0380601' WHERE cpinstser = 'SUD038 &06'
 UPDATE mdcp set cpinstser = 'SUD0400601' WHERE cpinstser = 'SUD040 &06'
 UPDATE mdvi set viinstser = 'SUD0200601' WHERE viinstser = 'SUD020 &06'
 UPDATE mdvi set viinstser = 'SUD0260601' WHERE viinstser = 'SUD026 &06'
 UPDATE mdvi set viinstser = 'SUD0270601' WHERE viinstser = 'SUD027 &06'
 UPDATE mdvi set viinstser = 'SUD0280601' WHERE viinstser = 'SUD028 &06'
 UPDATE mdvi set viinstser = 'SUD0290601' WHERE viinstser = 'SUD029 &06'
 UPDATE mdvi set viinstser = 'SUD0300601' WHERE viinstser = 'SUD030 &06'
 UPDATE mdvi set viinstser = 'SUD0330601' WHERE viinstser = 'SUD033 &06'
 UPDATE mdvi set viinstser = 'SUD0340601' WHERE viinstser = 'SUD034 &06'
 UPDATE mdvi set viinstser = 'SUD0350601' WHERE viinstser = 'SUD035 &06'
 UPDATE mdvi set viinstser = 'SUD0360601' WHERE viinstser = 'SUD036 &06'
 UPDATE mdvi set viinstser = 'SUD0380601' WHERE viinstser = 'SUD038 &06'
 UPDATE mdvi set viinstser = 'SUD0400601' WHERE viinstser = 'SUD040 &06'
 UPDATE mddi set diinstser = 'SUD0200601' WHERE diinstser = 'SUD020 &06'
 UPDATE mddi set diinstser = 'SUD0260601' WHERE diinstser = 'SUD026 &06'
 UPDATE mddi set diinstser = 'SUD0270601' WHERE diinstser = 'SUD027 &06'
 UPDATE mddi set diinstser = 'SUD0280601' WHERE diinstser = 'SUD028 &06'
 UPDATE mddi set diinstser = 'SUD0290601' WHERE diinstser = 'SUD029 &06'
 UPDATE mddi set diinstser = 'SUD0300601' WHERE diinstser = 'SUD030 &06'
 UPDATE mddi set diinstser = 'SUD0330601' WHERE diinstser = 'SUD033 &06'
 UPDATE mddi set diinstser = 'SUD0340601' WHERE diinstser = 'SUD034 &06'
 UPDATE mddi set diinstser = 'SUD0350601' WHERE diinstser = 'SUD035 &06'
 UPDATE mddi set diinstser = 'SUD0360601' WHERE diinstser = 'SUD036 &06'
 UPDATE mddi set diinstser = 'SUD0380601' WHERE diinstser = 'SUD038 &06'
 UPDATE mddi set diinstser = 'SUD0400601' WHERE diinstser = 'SUD040 &06'
END

GO
