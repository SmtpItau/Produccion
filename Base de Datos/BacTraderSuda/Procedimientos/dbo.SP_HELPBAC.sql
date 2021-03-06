USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HELPBAC]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado DBO.SP_HELPBAC    fecha de la secuencia de comandos: 05/04/2001 13:13:30 ******/
CREATE PROCEDURE [dbo].[SP_HELPBAC] 
    @objname varchar(92)             -- the table to check for constraints
   ,@nomsg   varchar(5) = 'msg'      -- 'nomsg' supresses printing of tbname (sp_help)
as
set nocount on
declare @objid    int           -- the object id of the table
       ,@indid    int           -- the index id of an index
       ,@cnstdes  varchar(255)  -- string to build up index desc
       ,@cnstname varchar(30)   -- name of const. currently under consideration
       ,@tptr     varbinary(16) -- pointer for building text strings.
       ,@i          int
       ,@thiskey    varchar(32)
       ,@cnstid     int
       ,@cnststatus int
       ,@numkeys    int
       ,@rkeyid     int
       ,@fkeyid     int
       ,@dbname     varchar(30)
declare
         @fkey1  int ,@fkey2  int ,@fkey3  int ,@fkey4  int ,@fkey5  int
        ,@fkey6  int ,@fkey7  int ,@fkey8  int ,@fkey9  int ,@fkey10 int
        ,@fkey11 int ,@fkey12 int ,@fkey13 int ,@fkey14 int ,@fkey15 int
        ,@fkey16 int
declare
         @rkey1  int ,@rkey2  int ,@rkey3  int ,@rkey4  int ,@rkey5  int
        ,@rkey6  int ,@rkey7  int ,@rkey8  int ,@rkey9  int ,@rkey10 int
        ,@rkey11 int ,@rkey12 int ,@rkey13 int ,@rkey14 int ,@rkey15 int
        ,@rkey16 int
declare
       @bitdisabled           integer
      ,@bitnotforreplication  integer
select
       @bitdisabled           = 0x4000
      ,@bitnotforreplication  = 0x200000
---- check to see that the object names are local to the current database.
if      @objname like '%.%.%'
   and  substring(@objname, 1, charindex('.', @objname) - 1) <> db_name()
   begin
   raiserror(15250,-1,-1)
   return (1)
   end
---- check to see if the table exists and initialize @objid.
select @objid = object_id(@objname)
---- table does not exist so return.
if @objid is null
   begin
   select @dbname=db_name()
   raiserror(15009,-1,-1,@objname,@dbname)
   return (1)
       
   end
declare cnst_csr cursor for
     select   c.constid, c.status, o.name
        from  SYSCONSTRAINTS c, SYSOBJECTS o
        where c.id = @objid and o.id = c.constid
        for read only
---- now check out each constraint, figure out its type and keys and
---- save the info in a temporary table that we'll print out at the end.
create table #SPCNSTTAB
(
    rowid               int           not null  identity
   ,cnst_type           varchar(48)   not null   -- 30 for name +    text for default
   ,cnst_name           varchar(30)   not null
   ,cnst_nonblank_name  varchar(30)   not null
   ,cnst_status         integer           null
   ,cnst_keys           text              null
)
create table #SPCNSTKEYS
(
    cnst_colid int not null
)
open cnst_csr
fetch cnst_csr into @cnstid, @cnststatus, @cnstname
while @@fetch_status >= 0
   begin
   if ((@cnststatus & 0xf) in (1,2)) -- primary key, unique
      begin
      if ((@cnststatus & 0xf) = 1)
         
       select @cnstdes = 'primary key'
      else
         select @cnstdes = 'unique'
      select   @indid = indid
         from  SYSINDEXES, SYSOBJECTS
         where sysobjects.id = @cnstid
         and   sysindexes.name = sysobjects.name
   
    if (@indid > 1)
         select @cnstdes = @cnstdes + ' (non-clustered)'
      else
         select @cnstdes = @cnstdes + ' (clustered)'
      ---- first we'll figure out what the keys are.
      select @i = 1
      while (@i <= 16)
       
         begin
         select @thiskey = index_col(@objname, @indid, @i)
         if @thiskey is null
            goto keysdone
         if @i=1
            begin
            insert into #SPCNSTTAB (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
               values (@cnstdes, @cnstname,@cnstname, @thiskey)
            select @tptr = textptr(cnst_keys) from #SPCNSTTAB
            end
         else
            begin
            select @thiskey = ', ' + @thiskey
                 
   if @tptr is not null
               updatetext #spcnsttab.cnst_keys @tptr null null @thiskey
            end
         select @i = @i + 1
         end --loop 16
         ---- when we get here we now have all the keys.
keysdone:
      end 
   else   -- not pkey,ukey
      if ((@cnststatus & 0xf) = 3) /* foreign key */
         begin
         select @cnstdes = 'foreign key'
         select
                @fkeyid = fkeyid, @rkeyid = rkeyid,
                @fkey1=fkey1, @fkey2=fkey2, @fkey3=fkey3,
                @fkey4=fkey4, @fkey5=fkey5, @fkey6=fkey6,
                @fkey7=fkey7, @fkey8=fkey8, @fkey9=fkey9,
                @fkey10=fkey10, @fkey11=fkey11,
                @fkey12=fkey12, @fkey13=fkey13,
              
  @fkey14=fkey14, @fkey15=fkey15,
                @fkey16=fkey16,
                @rkey1=rkey1, @rkey2=rkey2, @rkey3=rkey3,
                @rkey4=rkey4, @rkey5=rkey5, @rkey6=rkey6,
                @rkey7=rkey7, @rkey8=rkey8, @rkey9=rkey9,
          
                @rkey10=rkey10, @rkey11=rkey11,
                @rkey12=rkey12, @rkey13=rkey13,
                @rkey14=rkey14, @rkey15=rkey15,
                @rkey16=rkey16
            from  SYSREFERENCES
            where constid = @cnstid
        
    insert into #SPCNSTKEYS values(@fkey1)
         insert into #SPCNSTKEYS values(@fkey2)
         insert into #SPCNSTKEYS values(@fkey3)
         insert into #SPCNSTKEYS values(@fkey4)
         insert into #SPCNSTKEYS values(@fkey5)
         insert into #SPCNSTKEYS values(@fkey6)
         insert into #SPCNSTKEYS values(@fkey7)
         insert into #SPCNSTKEYS values(@fkey8)
         insert into #SPCNSTKEYS values(@fkey9)
         insert into #SPCNSTKEYS values(@fkey10)
         insert into #SPCNSTKEYS values(@fkey11)
         insert into #SPCNSTKEYS values(@fkey12)
         insert into #SPCNSTKEYS values(@fkey13)
         insert into #SPCNSTKEYS values(@fkey14)
         insert into #SPCNSTKEYS values(@fkey15)
         insert into #SPCNSTKEYS values(@fkey16)
         delete from #SPCNSTKEYS where cnst_colid = 0
         ---- need a unique index so we can use a cursor.
         create unique index ind1 on #SPCNSTKEYS(cnst_colid)
         execute('declare fkey_curs cursor for
                     select cnst_colid from #SPCNSTKEYS
                     for read only')
         open fkey_curs
         fetch fkey_curs into @i
         select @numkeys=1
         while @@fetch_status >= 0
            begin
            select @thiskey = col_name(@fkeyid, @i)
            ---- no comma for fist key column.
            if @numkeys = 1
               begin
               insert into #SPCNSTTAB (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
      
             values (@cnstdes, @cnstname,@cnstname, @thiskey)
               select @tptr = textptr(cnst_keys) from #SPCNSTTAB
               end
            else
               begin
               select @thiskey = ', ' + @thiskey
             
         if @tptr is not null
                  updatetext #SPCNSTTAB.cnst_keys @tptr null null @thiskey
               end
            select @numkeys=@numkeys+1
            fetch fkey_curs into @i
            end --loop key fetch
          
---- when we get here we now have all the keys.
         truncate table #SPCNSTKEYS
         drop index #SPCNSTKEYS.ind1
         deallocate fkey_curs
         insert into #SPCNSTKEYS values(@rkey1)
         insert into #SPCNSTKEYS values(@rkey2)
         insert into #SPCNSTKEYS values(@rkey3)
         insert into #SPCNSTKEYS values(@rkey4)
         insert into #SPCNSTKEYS values(@rkey5)
         insert into #SPCNSTKEYS values(@rkey6)
         insert into #SPCNSTKEYS values(@rkey7) 
         insert into #SPCNSTKEYS values(@rkey8)
         insert into #SPCNSTKEYS values(@rkey9)
         insert into #SPCNSTKEYS values(@rkey10)
         insert into #SPCNSTKEYS values(@rkey11)
         insert into #SPCNSTKEYS values(@rkey12)
       
         insert into #SPCNSTKEYS values(@rkey13)
         insert into #SPCNSTKEYS values(@rkey14)
         insert into #SPCNSTKEYS values(@rkey15)
         insert into #SPCNSTKEYS values(@rkey16)
         delete from #SPCNSTKEYS where cnst_colid =  0
         ---- need a unique index so we can use a cursor.
         create unique index ind1 on #SPCNSTKEYS(cnst_colid)
         insert into #SPCNSTTAB (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
            select   ' ' ,' ' ,@cnstname
                     ,'references ' + rtrim(db_name(rkeydbid))
                           + '.' + rtrim(
                  (select user_name(uid) from SYSOBJECTS where id = @rkeyid
                  )
                       
                  )
                           + '.'+object_name(@rkeyid) + ' ('
               from  SYSREFERENCES
               where constid = @cnstid
         select @tptr = textptr(cnst_keys) from #SPCNSTTAB
         execute('declare rkey_curs cursor for
                     select cnst_colid from #SPCNSTKEYS
                     for read only')
         open rkey_curs
         fetch rkey_curs into @i
         select @numkeys=1
         while @@fetch_status >= 0
        
     begin
            select @thiskey = col_name(@rkeyid, @i)
            ---- no comma for first key column.
            if @numkeys <> 1
               select @thiskey = ', ' + @thiskey
            if @tptr is not null
                      
     updatetext #spcnsttab.cnst_keys @tptr null null @thiskey
            select @numkeys=@numkeys+1
            fetch rkey_curs into @i
            end --loop
         ---- when we get here we now have all the keys.
         if @tptr is not null
            updatetext #spcnsttab.cnst_keys @tptr null null ')'
         truncate table #SPCNSTKEYS
         drop index #SPCNSTKEYS.ind1
         deallocate rkey_curs
         end
      else
         if ((@cnststatus & 0xf) = 4)    --        check constraint
            begin
            select @i = 1
            select @cnstdes = text from SYSCOMMENTS
               where id = @cnstid and colid = @i
            while @cnstdes is not null
               begin
               if @i=1
                  begin
                  -- get table check constraint
                  insert into #spcnsttab (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
                     select   'check table level ',@cnstname,@cnstname,' '
        
                       from  SYSCONSTRAINTS
                        where colid = 0 and constid = @cnstid
                  -- column level check
                  insert into #spcnsttab (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
            
          SELECT 'CHECK ON COLUMN ' + col_name(id, colid)
                           ,@cnstname,@cnstname,' '
                        from  SYSCONSTRAINTS
                        where colid > 0 and constid = @cnstid
                  select @tptr = textptr(cnst_keys) from #SPCNSTTAB
                  if @tptr is not null
                  updatetext #spcnsttab.cnst_keys @tptr 0 null null
                  end
               else
                  begin
                  if @tptr is not null
                     updatetext #spcnsttab.cnst_keys @tptr null null @cnstdes
                  end
               select @cnstdes = null
               select @cnstdes = text from SYSCOMMENTS
                  where id = @cnstid and colid = @i
               select @i = @i + 1
               end
            end
         else
            if ((@cnststatus & 0xf) = 5)    -- default
               begin
               select @i = 1
               select @cnstdes = text from SYSCOMMENTS
                  where id = @cnstid and colid = @i
               while @cnstdes is not null
                  begin
                  if @i=1
                     begin
                     insert into #spcnsttab (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
                        SELECT 'DEFAULT ON COLUMN ' + col_name(id, colid)
                              ,@cnstname,@cnstname,' '
                           from  SYSCONSTRAINTS
                           where  colid > 0 and constid = @cnstid
                     select @tptr = textptr(cnst_keys) from #SPCNSTTAB
                     if @tptr is not null
                        updatetext #spcnsttab.cnst_keys @tptr 0 null null
                     end
                  else
                     begin
                     if @tptr is not null
                        updatetext #spcnsttab.cnst_keys @tptr null null @cnstdes
                     end
                  select @cnstdes = null
   
                select @cnstdes = text from SYSCOMMENTS
                     where id = @cnstid and colid = @i
                  select @i = @i + 1
                  end
               end
            else
               insert into #SPCNSTTAB (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
                  values
                     ('*** INVALID TYPE FOUND IN SYSCONSTRAINTS ***'
                     ,'ERROR','ERROR','ERROR')
            fetch cnst_csr into @cnstid, @cnststatus,  @cnstname
        end --of major loop
        ---- find any rules or defaults bound by the sp_bind... method.
        insert into #SPCNSTTAB (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
           select 'RULE (BOUND WITH SP_BINDRULE       )'
                 ,object_name(c.domain),object_name(c.domain)
                 ,text
              from  SYSCOLUMNS c,SYSCOMMENTS m
              where c.id = @objid
                and m.id = c.domain
                and c.domain not in
        
                 (select constid from SYSCONSTRAINTS)
        insert into #SPCNSTTAB (cnst_type,cnst_name,cnst_nonblank_name,cnst_keys)
           select 'DEFAULT (BOUND WITH SP_BINDEFAULT)'
                 ,object_name(c.cdefault),object_name(c.cdefault)
                 ,text
              from SYSCOLUMNS c,SYSCOMMENTS m
              where c.id = @objid
                and m.id = c.cdefault
                and c.cdefault not in
                        (select constid from SYSCONSTRAINTS)
        ---- constraint status (type included)
        update #SPCNSTTAB
                set   cnst_status = cs.status
                from  #SPCNSTTAB tt1 ,SYSCONSTRAINTS cs
                where tt1.cnst_name=object_name(cs.constid)       
        update #SPCNSTTAB
                set   cnst_status = 0
                where cnst_status is null
    /*    if @nomsg <> 'nomsg'
           begin
           select 'object name' = @objname
           print ''
           end
 */
      
   ---- now print out the contents of the temporary index table.
        if (select count(*) from #SPCNSTTAB) <> 0
           select
                   'campo_tabla' = substring(cnst_type,19,35)
/*
                  ,'constraint_name' = cnst_name
            ,'status_enabled'      = -- 3=fkey ,4=check
                     case
                        when cnst_name = ' ' then ' '
                        when cnst_status & 0xf in (3,4) and
                             cnst_status & @bitdisabled  > 0 and
                             cnst_name <> ' '
                           then    'disabled'
                        when cnst_status & 0xf in (3,4) and
                             cnst_status & @bitdisabled = 0 and
                           
           cnst_name <> ' '
                           then    'enabled'
                        else       '(n/a)'
                     end
                  ,'status_for_replication'  =
                     case
           when cnst_name = ' ' then ' '
                        when cnst_status & 0xf in (3,4) and
                             cnst_status & @bitnotforreplication > 0 and
                             cnst_name <> ' '
                           then    'not_for_replication'
                        when cnst_status & 0xf in (3,4) and
                             cnst_status & @bitnotforreplication = 0 and
                             cnst_name <> ' '
                           then    'is_for_replication'
      
                   else       '(n/a)'
                     end
*/
                  ,'dato_default' = convert(char(10),cnst_keys)
                from      #SPCNSTTAB
                order by  cnst_nonblank_name ,cnst_name     
        else
--           select 'campo_table   'cno constraints have been defined for this object.'
            SELECT 'CAMPO_TABLA' = 'NO'
        print ''
/*  no existen referencias
        if (select count(*) from sysreferences where rkeyid = @objid) <> 0
           select
                   'table is referenced by ' =
                        db_name(r.fkeydbid) + '.'
                     +  rtrim(
               (select user_name(o.uid) from sysobjects o
                  where o.id = r.fkeyid               )
                             )
                     + '.' + object_name(r.fkeyid)       
                     + ': ' + object_name(r.constid)
               from      sysreferences r
               where     r.rkeyid = @objid
               order by  1
        else
     --      print 'no foreign keys reference this table.'
*/ 
deallocate  cnst_csr
return (0)
                                                                                                                                                                                                                                          
-- baccamdeutsche..sp_helpbac 'mdin ' 


GO
