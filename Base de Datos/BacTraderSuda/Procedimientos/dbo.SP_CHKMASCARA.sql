USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHKMASCARA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CHKMASCARA]( @cinstaux char(12)       ,
                                @cmascaux char(12)        ,
                                @cmesaux  char(2)  output ,
                                @canoaux  char(4)  output ,
                                @dfecaux  datetime output )
as
begin
     declare @cfecaux varchar(6)
     declare @nerror  integer
     declare @i       integer
     -- verifica que sea dia.-
     if charindex('DD',@cmascaux) > 0
        begin
             select @cfecaux = substring(@cinstaux,charindex('DD',@cmascaux),2)
             execute @nerror = SP_ESDIA @cfecaux
             if @nerror = 1
                -- 'dd' no es dia
                return 1
        end
     -- verifica que sea mes.-
     if charindex('MM',@cmascaux) > 0
        begin
             select @cfecaux = substring(@cinstaux,charindex('MM',@cmascaux),2)
             execute @nerror = SP_ESMES @cfecaux, @cmesaux output
        
      if @nerror = 1
                return 2
             
 end
     -- verifica que sea ao.-
     if charindex('AA',@cmascaux) > 0
        begin
             select @cfecaux = substring(@cinstaux,charindex('AA',@cmascaux),2)
             execute @nerror = SP_ESANO @cfecaux, @canoaux output
             if @nerror = 1
                -- 'aa' no es ao
                return 3
        end
     -- verifica que la fecha sea formato 'aammdd'.-
     if charindex('AAMMDD',@cmascaux) > 0
        begin
             select @cfecaux = substring(@cinstaux,charindex('AAMMDD',@cmascaux),6)
             print @cfecaux
             execute @nerror = SP_ESFECAMD @cfecaux, @dfecaux output
             if @nerror = 1
                -- 'aammdd' no es fecha
                return 4
        end
     -- verifica que la fecha sea formato 'ddmmaa'.-
     if charindex('DDMMAA',@cmascaux) > 0
        begin
             select @cfecaux = substring(@cinstaux,charindex( 'DDMMAA', @cmascaux),6)
             execute @nerror = SP_ESFECDMA @cfecaux, @dfecaux output
             if @nerror = 1
                -- 'ddmmaa' no es fecha
                return 4
        end
     -- otras validaciones.-
     select @i = 0
     while ( @i < 10 )
           begin
                select @i = @i + 1
                if substring(@cmascaux,@i,1) = ' '
                   begin
                        if substring(@cinstaux,@i,1) <> ' '
                           -- ' ' no es blanco
                           return 5
                   end
                if substring(@cmascaux,@i,1) = 'N'
                   begin
                        if charindex(substring(@cinstaux,@i,1),'0123456789') = 0
                           -- 'N' no es n£mero
                           return 6
                   end
           end
    -- ok!
    return 0
end


GO
