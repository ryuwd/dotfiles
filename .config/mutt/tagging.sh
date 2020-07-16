function get_mail_in_tagfolder() { 
    notmuch search 'folder:"pm/Labels.'$1'"' and 'folder:"pm/All Mail"'
}

function get_mail_tagged_as() { 
    notmuch search 'tag:"'$1'"'
}

function tag_mail_for_PM_tag() {
    notmuch tag +"$1" 'folder:"pm/Labels.'$1'"' and 'folder:"pm/All Mail"'

}

function untag_mail_for_PM_tag() {
    notmuch tag -"$1" 'folder:"pm/Labels.'$1'"' and 'folder:"pm/All Mail"'

}


function tag_mail_for_PM_tag_cust() {
    notmuch tag +"$2" 'folder:"pm/Labels.'$1'"' and 'folder:"pm/All Mail"'
    notmuch tag -"$2" 'NOT folder:"pm/Labels.'$1'"' and 'folder:"pm/All Mail"'
}

function sync_and_tag() {
    mbsync -V $1
    
    PM_OUT=$(notmuch new)
    
    notmuch tag +archive "folder:$1/Archive"

    tag_mail_for_PM_tag_cust "Mailing List" "mailing"
    tag_mail_for_PM_tag_cust "Marketing" "promo"
    tag_mail_for_PM_tag_cust "Social" "social"
    tag_mail_for_PM_tag_cust "Receipt" "receipt"
    tag_mail_for_PM_tag_cust "Update" "update"

    echo "$PM_OUT"

    if ! grep -q "No new mail." <<< "$PM_OUT"; then
        echo "We've got mail!"
        LASTLINE=$(echo "$PM_OUT" | tail -1)
        
        NMAILS=$(notmuch search tag:unread | wc -l)

        notify-send --icon=email -t 10000 "New mail ($NMAILS unread)" "$LASTLINE"
    fi

}
