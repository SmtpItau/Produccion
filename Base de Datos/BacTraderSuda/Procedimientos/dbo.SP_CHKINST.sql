USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHKINST]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CHKINST]
       (
        @cinstser char(10),
        @xfecemis char(10),
        @xfecvcto char(10),
        @cemlchr  char(4) ,
        @cmonemis char(03),
        @xinst    char(10)   output,
        @xinstser char(10)   output,
        @xprog    char(08)   output,
        @xcodigo  numeric(3) output,
        @xmonemis numeric(3) output,
        @xseriado char(01)   output
       )
as
begin
   set nocount on
 if substring(@cinstser,1,3) = 'PRC'
           select @xinstser = substring(@cinstser,1,3) + '-' + substring(@cinstser,5,2) + substring(@xfecemis,1,2) + substring(@xfecemis,9,2),
                  @xinst    = 'PRC'
                
        if substring(@cinstser,1,3) = 'PRT'
           select @xinstser = substring(@cinstser,1,3) + '-' + substring(@cinstser,5,4),
                  @xinst    = 'PRT'
                
        if substring(@cinstser,1,3) = 'PDP'
           select @xinstser = substring(@cinstser,1,3) + substring(@cinstser,5,3) + substring(@xfecemis,1,2) + substring(@xfecemis,9,2),
                  @xinst    = 'PDP'
                
        if substring(@cinstser,1,3) = 'PCC'
           select @xinstser = substring(@cinstser,1,3) + substring(@cinstser,5,1) + substring(@xfecemis,4,2) + substring(@xfecemis,1,2) + substring(@xfecemis,9,2),
                  @xinst    = 'PCC'
                
        if charindex(substring(@cinstser,1,4),'PRBC-PDBC') > 0
           select @xinstser = substring(@cinstser,1,4) + substring(@xfecvcto,4,2) + substring(@xfecvcto,1,2) + substring(@xfecvcto,9,2),
                  @xinst    = substring(@cinstser,1,4)
                
        if charindex(substring(@cinstser,1,4),'DPR -DPF ') > 0
           select @xinstser = substring(@cinstser,1,4) + substring(@xfecvcto,4,2) + substring(@xfecvcto,1,2) + substring(@xfecvcto,9,2),
                  @xinst    = substring(@cinstser,1,4)
        if substring(@cinstser,1,4) = 'PPBC'
           select @xinstser = substring(@cinstser,1,4) + substring(@cinstser,5,2) + substring(@xfecemis,1,2) + substring(@xfecemis,9,2),
                  @xinst    = 'PPBC'
                
        if substring(@cinstser,1,3) = 'PCD' and @cmonemis = '064'
           select @xinstser = substring(@cinstser,1,3) + 'US$' + substring(@cinstser,5,2) + substring(@cinstser,8,2),
                  @xinst    = 'PCDUS$'
                
        if substring(@cinstser,1,3) = 'PCD' and @cmonemis = '061'
           select @xinstser = substring(@cinstser,1,3) + substring(@cinstser,5,1) + substring(@xfecemis,4,2) + substring(@xfecemis,1,2) + substring(@xfecemis,9,2),
                  @xinst    = 'PCDUF'
                
        if substring(@cinstser,1,2) = 'LH' 
           begin 
               if charindex('*',@cinstser) > 0 begin
                     if substring(@cinstser,(charindex('*',@cinstser)+1),1) = '*' begin
                        select @xinstser = rtrim(ltrim(@cemlchr)) + rtrim(ltrim(substring(@cinstser,5,3))) + '**' + substring(@xfecemis,9,2)
                     end else begin
                        select @xinstser = rtrim(ltrim(@cemlchr)) + rtrim(ltrim(substring(@cinstser,5,3))) + ' *' + substring(@xfecemis,9,2)
                     end
                  end 
               else begin
                  if charindex('&',@cinstser) > 0  begin       
                      if substring(@cinstser,(charindex('&',@cinstser)+1),1) = '&' begin
                        select @xinstser = rtrim(ltrim(@cemlchr)) + rtrim(ltrim(substring(@cinstser,5,3))) + '&&' + substring(@xfecemis,9,2)
                      end else 
                        select @xinstser = rtrim(ltrim(@cemlchr)) + rtrim(ltrim(substring(@cinstser,5,3))) + ' &' + substring(@xfecemis,9,2)
                  end else begin
                 select @xinstser = rtrim(ltrim(@cemlchr)) + rtrim(ltrim(substring(@cinstser,5,3))) + substring(@xfecemis,1,2) + substring(@xfecemis,9,2)
                  end
               end             select @xinst = 'LCHR'
           end                   
                
        if substring(@cinstser,1,3) = 'PRD' 
           select @xinstser = substring(@cinstser,1,3) + substring(@cinstser,5,3) + substring(@xfecemis,1,2) + substring(@xfecemis,9,2),
                  @xinst    = 'PRD'
                
        select @xprog    = inprog,
               @xcodigo  = incodigo,
               @xmonemis = inmonemi,
               @xseriado = inmdse 
               from VIEW_INSTRUMENTO          
               where inserie = @xinst
    set nocount off
    select 'OK'
    return 0
end


GO
