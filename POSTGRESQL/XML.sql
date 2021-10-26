--Загрузка из дата каталога
-- узнать где дата каталог
	SHOW data_directory;
	
-- загрузить туда файлы

--загрузить файл целиком в клонку с типом xml
                insert into public.target_conf (xml_row)
                SELECT XMLPARSE(DOCUMENT convert_from(
                        pg_read_binary_file('c:\Program Files\PostgreSQL\12\data\upload\FileName.xml'), 'UTF8'));
						
--запрос сразу из файла
	SELECT
     (xpath('//@elementId',source.xml))::text AS elementId
    ,(xpath('//@value',source.xml))::text AS value
    ,(xpath('//@valueDate',source.xml))::text AS valueDate
    ,(xpath('//@reportRef',source.xml))::text AS reportRef
    ,(xpath('//@tradeId',source.xml))::text AS tradeId
    ,(xpath('//@DESC',source.xml))[1]::text AS DESC
    ,cast((xpath('//@UPDATEDATE',source.xml))[1]::text as date) AS UPDATEDATE
    ,cast((xpath('//@STARTDATE',source.xml))[1]::text as date) AS STARTDATE
    ,cast((xpath('//@ENDDATE',source.xml))[1]::text as date) AS ENDDATE
    ,((xpath('//@ISACTIVE',source.xml))[1]::text)::boolean AS ISACTIVE
FROM unnest(xpath('//rmDataItems', XMLPARSE(DOCUMENT convert_from(pg_read_binary_file('c:\Program Files\PostgreSQL\12\data\NAME.xml'), 'UTF8'))
))  AS source(xml)

--запрос из таблицы

	insert into  TTT(elementid, value, valuedate, reportref, tradeid)
SELECT
    unnest(xpath('//@elementId', source))::text::bigint               AS elementId
     , unnest(xpath('//@value', source))::text::double precision                AS value
     --, xpath('//@valueDate', source)                          AS valueDate
     , cast((xpath('//@valueDate', source))[1]::text as date) AS valueDate
     , (xpath('//@reportRef', source))[1]::text::int               AS reportRef
     , (xpath('//@tradeId', source))[1]::text::bigint                 AS tradeId

FROM (
         SELECT unnest(xpath('//rmDataItems', oc.xml_row)) AS source
         FROM public.target_conf AS oc
     ) AS source
