--Загрузка из дата каталога
-- узнать где дата каталог
	SHOW data_directory;
	
-- загрузить оттуда файлы

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


--пример файла

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<rmDataPacket xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exportDate="2021-10-20T21:03:45" key="B839925411164D6EA44F8B6E1B425475" lastPack="false" packNumber="1" packSize="15000" totalPackets="803" totalRmDataItems="12030469" xsi:noNamespaceSchemaLocation="rmDataPacket.xsd">
	<rmDataItems reportRef="12" tradeId="12238060" valueDate="2021-10-19">
		<rmDataItem elementId="9048" value="-5.77"/>
		<rmDataItem elementId="9270" value="-0.2"/>
		<rmDataItem elementId="17001" value="0.27"/>
		<rmDataItem elementId="9272" value="-2.63"/>
		<rmDataItem elementId="12532" value="-0.03"/>
		<rmDataItem elementId="15574" value="0.3"/>
		<rmDataItem elementId="9049" value="-4.14"/>
		<rmDataItem elementId="7755" value="-10.48"/>
		<rmDataItem elementId="8304" value="0.46"/>
		<rmDataItem elementId="17002" value="-6.78"/>
		<rmDataItem elementId="8305" value="104.16"/>
		<rmDataItem elementId="9355" value="-847.07"/>
		<rmDataItem elementId="8306" value="-421.46"/>
		<rmDataItem elementId="9271" value="-0.77"/>
	</rmDataItems>
	<rmDataItems reportRef="12" tradeId="12238085" valueDate="2021-10-19">
		<rmDataItem elementId="9271" value="0.05"/>
		<rmDataItem elementId="12532" value="-187.01"/>
		<rmDataItem elementId="15614" value="-209.43"/>
		<rmDataItem elementId="9272" value="-1.02"/>
		<rmDataItem elementId="7754" value="11.79"/>
		<rmDataItem elementId="17001" value="-0.02"/>
		<rmDataItem elementId="9270" value="0.01"/>
		<rmDataItem elementId="9048" value="-5.64"/>
	</rmDataItems>