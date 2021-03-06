USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONTOESCRITO_MONEDA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_MONTOESCRITO_MONEDA]
    (
    @nnumero numeric (19,4)  ,
    @mtoesc  char (170) OUTPUT ,
    @nMoneda numeric (3)
    )
as
begin
set nocount on
 declare @decimal char (16) ,
  @denomi   char (06) ,
  @i  integer  ,
  @z  char (255) ,
  @k  char (255) ,
  @c  integer  ,
  @d  integer  ,
  @u  integer  ,
  @v  integer  ,
  @n  char (255) ,
  @frase   char (10) ,
  @frase1   char (10) ,
  @x  char (10) ,
  @y  char (10) ,
  @gloMoneda char (50),
  @cMdaMx CHAR(01)

 Select @cMdaMx = mnmx FROm VIEW_Moneda Where mncodmon =@nMoneda 

 select @x  = '( '     ,
  @y  = ' . ) '    ,
  @decimal = substring(str(@nnumero,19,4),16,4)
 if @nnumero=0.0
 begin
  select 'CERO'
  
 end
 if @nnumero>99999999999999
 begin
  select '*'
 end
 select @n = '   ' + ' ' + substring(str(@nnumero,19,4),1,14) ,
  @i = 1       ,
  @z = ''
 while rtrim(substring(@n,18-(@i*3-1),3))<>' '
 begin
  select @k = substring(@n,18-(@i*3-1),3)
  select @c = convert(integer,substring(@k,1,1)) ,
   @d = convert(integer,substring(@k,2,1)) ,
   @u = convert(integer,substring(@k,3,1)) ,
   @v = convert(integer,substring(@k,2,2))
  if @i>1
  begin
   if (@i=2 or @i=4) and convert(integer,substring(@k,1,3))>0
    select @z = ' MIL '+rtrim(@z)
   if @i=3 and convert(integer,substring(@n,7,6))>0
   begin
    if convert(integer,substring(@k,1,3))=1
     select @z = ' MILLON '+rtrim(@z)
    else
     select @z = ' MILLONES '+rtrim(@z)
   end
   if @i=5 and convert(integer,substring(@k,1,3))>0
   begin
    if convert(integer,substring(@k,1,3))=1
     select @z = ' BILLON '+rtrim(@z)
    else
     select @z = ' BILLONES '+rtrim(@z)
   end
  end
  if @v>0
  begin
   if @v<16
   begin
    select @frase = rtrim(glosa) from MDDESNUM where indice=@v
    select @z = rtrim(@frase)+rtrim(@z)
   end
   else
    if @v<20
    begin
     select @frase = rtrim(glosa) from MDDESNUM where indice=@u
     select @z = 'DIECI'+rtrim(@frase)+rtrim(@z)
    end
    else
     if @v=20
      select @z = 'VEINTE'+rtrim(@z)
     else
      if @v<30
      begin
       select @frase = rtrim(glosa) from MDDESNUM where indice=@u
       select @z = 'VEINTI'+rtrim(@frase)+rtrim(@z)
      end
      else
       if @u=0
       begin
        select @frase = rtrim(glosa) from MDDESNUM2 where indice=@d
        select @z = rtrim(@frase)+rtrim(@z)
       end
       else
       begin
        select @frase = rtrim(glosa) from MDDESNUM2 where indice=@d
        select @frase1 = rtrim(glosa) from MDDESNUM where indice=@u
        select @z = rtrim(@frase)+' Y '+rtrim(@frase1)+rtrim(@z)
       end
  end
  if @c>0
  begin
   if @c=1
   begin
    if @v=0
     select @z = 'CIEN '+rtrim(@z)
    else
     select @z = 'CIENTO '+rtrim(@z)
   end
   else
    if @c=2 or @c=3 or @c=4 or @c=6 or @c=8
    begin
     select @frase = rtrim(glosa) from MDDESNUM where indice=@c
     select @z = rtrim(@frase)+'CIENTOS '+rtrim(@z)
    end
    else
     if @c=5
      select @z = 'QUINIENTOS '+rtrim(@z)
     else
      if @c=7
       select @z = 'SETECIENTOS '+rtrim(@z)
      else
       if @c=9
        select @z = 'NOVECIENTOS '+rtrim(@z)
  end
  if rtrim(@n) is null
   break
  else
  begin
   select @i = @i + 1
   continue
  end
 end
 if @decimal='0000'
  select @decimal = '' ,
   @denomi  = ''
 else
 begin
  select @decimal = ' CON '+rtrim(@decimal)+'/10000'
 end
 SELECT @gloMoneda = CASE @nMoneda
     WHEN 999 THEN 'PESOS'
     WHEN 998 THEN 'UNIDADES DE FOMENTO'
     WHEN 994 THEN 'DOLARES'
     WHEN 13  THEN 'DOLARES'
     WHEN 142  THEN 'EUROS'
     WHEN 72  THEN 'YENES JAPONESES'
     ELSE ''
     END

 select @mtoesc = RTRIM( LTRIM ( rtrim(@x)+' '+rtrim(@z)+@decimal ))+ ' ' + LTRIM(RTRIM(@gloMoneda)) + ' ' + rtrim(@y)
end

GO
