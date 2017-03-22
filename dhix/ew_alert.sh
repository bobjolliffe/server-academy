#!/bin/bash

STARTDATE=$(date -d "last Monday -7 days")

echo "<html>"
echo "<body>"

echo "SELECT 
  datavalue.value,
  datavalue.storedby,
  datavalue.lastupdated,
  datavalue.created,
  period.startdate,
  organisationunit.name,
  dataelement.name
FROM
  public.dataelement,
  public.dataelementgroup,
  public.dataelementgroupmembers,
  public.datavalue,
  public.organisationunit,
  public.period,
  public.periodtype
WHERE
  datavalue.value IS NOT NULL AND datavalue.value !='' AND datavalue.value != '0' AND
  dataelement.dataelementid = dataelementgroupmembers.dataelementid AND
  dataelementgroupmembers.dataelementgroupid = dataelementgroup.dataelementgroupid AND
  datavalue.periodid = period.periodid AND
  datavalue.sourceid = organisationunit.organisationunitid AND
  datavalue.dataelementid = dataelement.dataelementid AND
  period.periodtypeid = periodtype.periodtypeid AND
  periodtype.name = 'Weekly' AND
  period.startdate = '$STARTDATE' AND
  dataelementgroup.name = 'Weekly Early Warning';" | psql -H dhims

echo "</body>"
echo "</html>"
