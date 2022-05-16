USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEETABEDW]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEETABEDW]
                  ( @codtab integer )
as
begin
 if @codtab=3
  select tbcodigo+convert(char(2),tbreg10) ,  --** (2) ciudades
   tbglosa
  from MDTB02
  where tbtipo=@codtab or tbtipo=1
  order by tbglosa
 else
  select tbcodigo+convert(char(2),tbreg10) , --** (2) ciudades y (3) comunas **--
   tbglosa
  from MDTB02
  order by tbglosa
 return
end
--select * from MDTB02
--sp_help MDTB02
--select tbcodigo+convert(char(2),tbregion),tbglosa from MDTB02 where tbtipo=3

GO
