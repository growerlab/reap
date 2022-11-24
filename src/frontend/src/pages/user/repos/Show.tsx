import React from "react";
import { useTitle } from "react-use";
import { useOutlet } from "react-router-dom";

import { getTitle } from "../../../core/common/document";
import i18n from "../../../core/i18n/i18n";
import Error404 from "../../common/404";
import { useRepositoryPathGroup } from "../../../core/components/hook/repository";
import { EuiListGroup } from "@elastic/eui";

interface Props extends React.PropsWithChildren {
  defaultChild?: React.ReactElement;
}

export default function RepositoryShow(props: Props) {
  useTitle(getTitle(i18n.t("repository.menu")));

  const outlet = useOutlet();
  const defaultOutlet = outlet === null ? props.defaultChild : outlet;

  const { isInvalid } = useRepositoryPathGroup();
  if (isInvalid) {
    return <Error404 />;
  }

  const myContent = [
    {
      label: i18n.t("repository.menus.code"),
      href: "#/display/list-group",
      iconType: "calendar",
      isActive: true,
    },
    {
      label: i18n.t("repository.menus.branchs"),
      href: "#/display/list-group",
      iconType: "clock",
    },
    {
      label: i18n.t("repository.menus.tags"),
      href: "#/display/list-group",
      iconType: "compute",
    },
    {
      label: i18n.t("repository.menus.pull_requests"),
      href: "#/display/list-group",
      iconType: "copyClipboard",
    },
    {
      label: i18n.t("repository.menus.webhooks"),
      href: "#/display/list-group",
      iconType: "crosshairs",
    },
    {
      label: i18n.t("repository.menus.settings"),
      href: "#/display/list-group",
      iconType: "crosshairs",
    },
  ];

  return (
    <div className="flex fixed top-18 h-full w-full">
      <div className="flex flex-row w-full ">
        <div className="flex-none bg-gray-100 border-y-0 border-l-0 border-solid border-r border-gray-200">
          <div className="w-52 mt-3">
            <EuiListGroup
              listItems={myContent}
              color="primary"
              size="s"
              gutterSize="s"
              // flush
              wrapText
            />
          </div>
        </div>
        <div className="flex-auto overflow-auto ">
          <div className="space-y-1 p-5">
            {defaultOutlet}
            <div className=" h-96"></div>sdf
            <div className=" h-96"></div>sdf
            <div className=" h-96"></div>sdf
            <div className=" h-96"></div>sdf
            <div className=" h-96"></div>sdf
          </div>
        </div>
      </div>
    </div>
  );
}
