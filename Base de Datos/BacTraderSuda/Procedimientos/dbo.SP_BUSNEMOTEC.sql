USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSNEMOTEC]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSNEMOTEC]( @cinstaux  char(12)        ,
                                @carchivo  char(12) output ,
                                @cmascara  char(12) output ,
                                @cmesaux   char(2)  output ,
                                @canoaux   char(2)  output ,
                                @dfecaux   datetime output )
as
begin
set nocount on
      declare @nerror    integer
      declare @cllavaux  char(12)
      declare @cmascaux  char(12)
      declare @cnemotec  char(12)
      declare @i         integer
      declare @j         integer
      select @cmascaux=@cinstaux
      select @i = datalength( @cinstaux )
      while ( @i > 2 ) begin
             select @cllavaux = substring( @cinstaux, 1, @i )
             select @carchivo='*'
             select @cnemotec = msnemo    ,
                    @carchivo = msarchivo
                    from VIEW_MASCARA_INSTRUMENTO
                    where msmascara = @cllavaux
             if @carchivo<>'*' begin
                       select @cmascara = @cllavaux + space(12-datalength(@cllavaux))
                       execute @nerror = SP_CHKMASCARA @cinstaux        ,
                                                       @cmascaux        ,
                                                       @cmesaux  output ,
                                                       @canoaux  output ,
                                                       @dfecaux  output
                       return @nerror
                  end
             else
                  begin
                       select @j = @i
                       while ( @j > 2 )
                        begin
                             select @cllavaux = stuff(@cllavaux,@j,1,'!')+space(12-datalength(@cllavaux))
                             select @cmascaux = msmascara ,
                                    @cnemotec = msnemo    ,
                                    @carchivo = msarchivo
                                    from VIEW_MASCARA_INSTRUMENTO
                                    where msmascara = @cllavaux
                             if @@rowcount = 1
                                  begin
                                       select @cmascara = substring( @cinstaux, 1, @i )
                                       select @cmascara = @cmascara + space(12-datalength(@cmascara))
                                       execute @nerror = SP_CHKMASCARA @cinstaux        ,
                                                                       @cmascaux        ,
                                                                       @cmesaux  output ,
                                                                       @canoaux  output ,
                                                                       @dfecaux  output
                                       return @nerror
                                  end
                             -- atras.-
                             select @j = @j - 1
                        end
                    end
           -- atras.-
           select @i = @i - 1
       end
       -- no coincidio con ninguna mascara.-
       return 7
end


GO
