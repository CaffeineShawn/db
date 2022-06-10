package com.caffeineshawn.db_backend.listener;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.caffeineshawn.db_backend.entity.Track;

import java.util.ArrayList;
import java.util.List;

public class OrderTrackExcelListener extends AnalysisEventListener<Track> {
    private List<Track> trackList = new ArrayList<>();

    @Override
    public void invoke(Track track, AnalysisContext analysisContext) {
        trackList.add(track);
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
        System.out.println("接收完毕");
    }

    public List<Track> getTrackList() {
        return trackList;
    }

    public void setTrackList(List<Track> trackList) {
        this.trackList = trackList;
    }

    @Override
    public String toString() {
        return "OrderTrackExcelListener{" +
                "trackList=" + trackList +
                '}';
    }
}

