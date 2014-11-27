package com.yodde.memberModel;

import java.util.List;

public interface MemberDao {
	public int 		memberJoin(MemberDto memberDto);
	public int		memberJoinAuth(MemberDto memberDto);
	public boolean 	isExistMember(String id);
	public MemberDto selectMember(String id);
	public List<MemberDto> selectMembersByNick(String query);
	public int		updateMember(MemberDto memberDto);
}
